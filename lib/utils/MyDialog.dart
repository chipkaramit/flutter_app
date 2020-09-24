import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:flutter/material.dart';

// https://blogs.ashrithgn.com/set-up-app-loading-progress-indicator-dialog/
class MyDialog
{
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async
    {
        return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context)
            {
              return new WillPopScope(
                  onWillPop: () async => false,
                  child: SimpleDialog(
                      key: key,
                      backgroundColor: Colors.black54,
                      children: <Widget>[
                        Center(
                          child: Column(children: [
                            CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),),
                            SizedBox(height: 10,),
                            //Text("Please Wait....",style: TextStyle(color: Colors.white),)
                            Text(AppLocalizations.of(context).translate('alert_please_wait'),style: TextStyle(color: Colors.white),)
                          ]),
                        )
                      ]));
            });
    }
}