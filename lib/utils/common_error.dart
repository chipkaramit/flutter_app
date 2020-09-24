import 'package:fiftyoneeast/util/AppLanguage.dart';
import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            //AppLocalizations.of(context).translate('progress_something'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            //child: Text('Retry', style: TextStyle(color: Colors.black)),
            child: Text(AppLocalizations.of(context).translate('button_retry'), style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}
