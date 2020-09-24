import 'package:fiftyoneeast/util/AppLanguage.dart';
import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:fiftyoneeast/util/PreferenceUtils.dart';
import 'package:fiftyoneeast/view/registration/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CustomWidget.dart';

class Logout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogoutOverlayState();
  }
}

class LogoutOverlayState extends State<Logout> {
  @override
  Widget build(BuildContext context) {

    var appLanguage = Provider.of<AppLanguage>(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: 180.0,
            decoration: new BoxDecoration(
                color: CustomWidget().gradientAppBar,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(120.0),
                  topRight: const Radius.circular(120.0),
                )),
            child: Column(
              children: <Widget>[
                //---- Logout label
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Text(AppLocalizations.of(context).translate('logout_successful'),

                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                )),

                //--- ok Button

                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonTheme(
                          height: 50.0,
                          minWidth: 210.0,
                          child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            splashColor: Colors.white.withAlpha(40),
                            child: Text(AppLocalizations.of(context).translate('alert_button_ok'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: CustomWidget().gradientAppBar,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            onPressed: () {
                              setState(()
                              {
                                //--- clear all data from share Preference
                                PreferenceUtils.getInstance();
                                //PreferenceUtils.clear();
                                PreferenceUtils.remove(PreferenceUtils.KEY_CUSTOMER_INFO);
                                PreferenceUtils.remove(PreferenceUtils.KEY_CUSTOMER_NOTIFICATION);

                                String  strSelectedLanguage = PreferenceUtils.getString(PreferenceUtils.KEY_CUSTOMER_LANGUAGE, defValue: "");
                                if(strSelectedLanguage!= null && strSelectedLanguage!="")
                                {
                                  if(strSelectedLanguage == "English")
                                  {
                                    appLanguage.changeLanguage(Locale("en")); // english
                                  }
                                  else
                                  {
                                    appLanguage.changeLanguage(Locale("ar")); // Arebic
                                  }
                                }
                                else
                                  {
                                    appLanguage.changeLanguage(Locale("en")); // english
                                  }


                                Future.delayed(Duration(seconds: 2));
                                //org Navigator.of(context).pushNamedAndRemoveUntil( '/login', (r) => false);

                                Navigator.of(context).pushAndRemoveUntil(
                                  // the new route
                                  MaterialPageRoute(builder: (BuildContext context) => LoginScreen(),),
                                  // this function should return true when we're done removing routes
                                  // but because we want to remove all other screens, we make it
                                  // always return false
                                      (Route route) => false,
                                );
                              });
                            },
                          )),
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
