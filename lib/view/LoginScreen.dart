import 'package:connectivity/connectivity.dart';
import 'package:fiftyoneeast/blocs/LoginBloc.dart';
import 'package:fiftyoneeast/models/login_respmodel.dart';
import 'package:fiftyoneeast/models/login_rqstmodel.dart';
import 'package:fiftyoneeast/networking/response.dart';
import 'package:fiftyoneeast/util/AppLanguage.dart';
import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:fiftyoneeast/util/CustomWidget.dart';
import 'package:fiftyoneeast/util/MyConnectivity.dart';
import 'package:fiftyoneeast/util/MyDialog.dart';
import 'package:fiftyoneeast/util/PreferenceUtils.dart';
import 'package:fiftyoneeast/util/ToastMsg.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoginScreenUI();
  }
}

class LoginScreenUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreenUI> {
  var _loginFormKey = GlobalKey<FormState>(debugLabel: 'loginFormKey');
  String strEmail = "", strMobileNumber = "", strPassword = "";

  LoginBloc loginBloc;
  LoginRequestModel request;
  ToastMsg toast = new ToastMsg();
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity connectivity = MyConnectivity.instance;
  //ProgressDialog progressDialog;

  @override
  void initState()
  {
    super.initState();
    loginBloc = LoginBloc();
    PreferenceUtils.getInstance();
    connectivity.initialise();
    connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });

    //progressDialog = null;
  }

  @override
  void dispose() {

    loginBloc.dispose();
    connectivity.disposeStream();
    //progressDialog = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate('title_login')),
          flexibleSpace: CustomWidget().myAppBarColor(),
        ),
        body: Form(
          key: _loginFormKey,
          child: Container(
            decoration: CustomWidget().customParentBgDecoration(),

            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[

                  //---- Mobile Number
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 30),
                    child: StreamBuilder<String>(
                        stream: loginBloc.mobile,
                        builder: (context, snapshot)
                        {
                          String errorMsg;
                          if(snapshot.hasError)
                          {
                            errorMsg = AppLocalizations.of(context).translate('common_error_mobile');
                          }
                          return TextFormField(
                            //controller: emailController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(color: Colors.white),
                            //decoration: CustomWidget().customTextFormFieldBorderTest(AppLocalizations.of(context).translate('mobile_number'), snapshot.error),
                            decoration: CustomWidget().customTextFormFieldBorderTest(AppLocalizations.of(context).translate('mobile_number'), errorMsg),
                            //validator: Validation().validateMobile,
                            maxLength: 10,
                            /*onSaved: (String val)
                          {
                            strMobileNumber = val;
                          },*/
                            onChanged: loginBloc.mobileChange,
                          );
                        }),
                  ),

                  //----- Password
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: StreamBuilder<String>(
                        stream: loginBloc.password,
                        builder: (context, snapshot)
                        {
                          String errorMsg;
                          if(snapshot.hasError)
                          {
                            errorMsg = AppLocalizations.of(context).translate('common_error_password_six_character_long');
                          }
                          return TextFormField(
                            obscureText: true,
                            //controller: passwordController,
                            style: TextStyle(color: Colors.white),
                            //decoration: CustomWidget().customTextFormFieldBorderTest(AppLocalizations.of(context).translate('password'), snapshot.error),
                            decoration: CustomWidget().customTextFormFieldBorderTest(AppLocalizations.of(context).translate('password'), errorMsg),
                            //validator: Validation().validatePassword,
                            /*onSaved: (String val)
                          {
                            strPassword = val;
                          },*/
                            onChanged: loginBloc.passwordChanged,
                          );
                        }),
                  ),

                  //---- Forgot password
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: FlatButton(
                      child: Text(AppLocalizations.of(context).translate('forgot_your_password')),
                      textColor: Colors.white,
                      onPressed: () {
                        //--- call forgot Password Activity
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ));
                      },
                    ),
                  ),

                  //----- Sign In Button
                  Container(
                    height: CustomWidget().buttonHeight(),
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: StreamBuilder<bool>(
                        stream: loginBloc.loginCheck,
                        builder: (context, snapshot)
                        {
                          return FlatButton(
                            textColor: Colors.white,
                            color: Colors.transparent,
                            child: Text(AppLocalizations.of(context).translate('sign_in')),
                            shape: new RoundedRectangleBorder(side: new BorderSide(color: Colors.white, width: 1.0)),
                            onPressed: ()
                            {
                              setState(()
                              {
                                if (snapshot.hasData)
                                {
                                  /*//--- check internet connection
                                  if(_source.keys.toList()[0] == ConnectivityResult.none)
                                  {
                                    toast.getCustomToastNoInternet(context);
                                  }
                                  else
                                  {
                                  }*/


                                  MyDialog.showLoadingDialog(context, _loginFormKey);//invoking dialog

                                  loginBloc.getAllLoginData(context);

                                  loginBloc.loginDetailsStream.listen((value)
                                  {
                                    Response<LoginResponseModel> result = value;

                                    switch (result.status)
                                    {
                                      case Status.LOADING:
                                        break;

                                      case Status.COMPLETED:
                                        LoginResponseModel loginResponse = result.data;

                                        if (loginResponse.data != null)
                                        {
                                          Navigator.of(_loginFormKey.currentContext,rootNavigator: true).pop();//close the dialoge

                                          if (loginResponse.data.toJson().length > 0 && loginResponse.data.toJson().isNotEmpty)
                                          {
                                            //toast.getCustomToast(context,'Login Successful ! Welcome ${loginResponse.data.firstName}');
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) =>
                                                    WillPopScope(
                                                      onWillPop: (){},
                                                      child:

                                                      new AlertDialog(
                                                        title: new Text(AppLocalizations.of(context).translate('alert_title_success')),
                                                        //content: Text('Login Successful ! Welcome ${loginResponse.data.firstName}'),
                                                        content: Text(AppLocalizations.of(context).translate('login_success') + '${loginResponse.data.firstName}'),
                                                        actions: <Widget>[
                                                          new FlatButton(
                                                            onPressed: ()
                                                            {
                                                              //Navigator.of(context, rootNavigator: true).pop(); // dismisses only the dialog and returns nothing
                                                              PreferenceUtils.putObject(PreferenceUtils.KEY_CUSTOMER_INFO,loginResponse);
                                                              Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
                                                            },
                                                            child: new Text(AppLocalizations.of(context).translate('alert_button_ok')),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                            );

                                            //PreferenceUtils.putObject(PreferenceUtils.KEY_CUSTOMER_INFO,loginResponse);
                                            //Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
                                            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);


                                          }
                                        }
                                        else
                                        {
                                          Navigator.of(_loginFormKey.currentContext,rootNavigator: true).pop();//close the dialoge

                                          //toast.getCustomAlertDialog(context, "Invalid", 'Invalid Username and Password');
                                          toast.getCustomAlertDialog(context, AppLocalizations.of(context).translate('alert_title_invalid'),
                                              AppLocalizations.of(context).translate('login_invalid'));
                                        }
                                        //return CategoryList(categoryList: snapshot.data.data);
                                        break;

                                      case Status.ERROR:
                                        Navigator.of(_loginFormKey.currentContext,rootNavigator: true).pop();//close the dialoge


                                        //toast.getCustomAlertDialog(context, "Error", 'Something get wrong!!!');
                                        toast.getCustomAlertDialog(context, AppLocalizations.of(context).translate('alert_title_error'),
                                            AppLocalizations.of(context).translate('alert_msg_something'));

                                        break;
                                    }
                                  });
                                }
                                else
                                {
                                  //toast.getCustomToast(context, "Enter required field");
                                  toast.getCustomToast(context, AppLocalizations.of(context).translate('enter_all_required_field'));
                                }
                              });
                            },
                          );
                        }),
                  ),

                  //---- terms and condition and privacy
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: AppLocalizations.of(context).translate('login_terms_and_condition1'),
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context).translate('login_terms_and_condition2'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            /*recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                //launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },*/
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context).translate('login_terms_and_condition3'),
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context).translate('login_terms_and_condition4'),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            /*recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                //launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },*/
                          )
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
