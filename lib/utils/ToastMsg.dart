import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMsg
{
 // FlutterToast flutterToast;

  //Success MSG
  getCustomToast(BuildContext context,String msg)
  {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

    /*flutterToast = FlutterToast(context);
    return  flutterToast.showToast(

      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );*/
  }

  getSuccFeedbackSubmit(BuildContext context)
  {
    return Fluttertoast.showToast(
        msg: "Feedback Submitted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  getCustomAlertDialog(BuildContext context, String title, String msg) async
  {
    await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) =>
        WillPopScope(
          onWillPop: (){},
          child: new AlertDialog(
                title: new Text('${title}'),
                content: Text('${msg}'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: ()
                    {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    //child: new Text('OK'),
                    child: new Text(AppLocalizations.of(context).translate('alert_button_ok')),
        ),
      ],
    ),
    ));
  }

  //No internet connection
  getCustomToastNoInternet(BuildContext context)
  {
    return Fluttertoast.showToast(
        msg: AppLocalizations.of(context).translate('no_internet_connection'),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }
}