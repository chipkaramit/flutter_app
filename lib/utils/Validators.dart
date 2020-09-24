
import 'dart:async';

import 'package:fiftyoneeast/blocs/CreatePasswordBloc.dart';
import 'package:fiftyoneeast/util/AppLocalizations.dart';
import 'package:flutter/material.dart';

mixin Validators
{
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink)
      {
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (regex.hasMatch(email)) {
          print("EMAIL:$email");
          sink.add(email);
        }
        else {
          sink.addError('Enter Valid Email');
        }
      }
  );


  var mobileValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink)
      {
        if (mobile.length == 10 && (mobile.startsWith("9") || mobile.startsWith("8") || mobile.startsWith("7"))) {
          sink.add(mobile);
        }
        else {
          sink.addError('Invalid Mobile Number');
          //sink.addError(AppLocalizations.of(myContext).translate('common_error_mobile'));
        }
      }
  );

  //---- Password validation
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink)
      {
        if (password.length >6)
        {
          CreatePasswordBloc.passWord = password;
          sink.add(password);
        }
        else {
          //sink.addError('Invalid password');
          sink.addError('Your password should be more then 6 char long');
        }
      }
  );
  var confirmPassValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink)
      {
        if (password.length >6)
        {
          if(CreatePasswordBloc.passWord!=password)
            {
              sink.addError('Confirm Password dose not match!!!');
            }
          else{
            //print("CONFIRM PASSWORD: $createPasswordBloc.passWord $password");
            sink.add(password);
          }

        }
        else {
          //sink.addError('Invalid password');
          sink.addError('Your password should be more then 6 char long');
        }
      }
  );



  //---- blank filed
  var emptyValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (data, sink)
      {
        if (data.length >0)
        {
          sink.add(data);
        }
        else {
          sink.addError('Invalid data');
        }
      }
  );

  //---- check box filed
  var checkBoxValidator = StreamTransformer<bool, bool>.fromHandlers(
      handleData: (check, sink)
      {
        if (check == true)
        {
          sink.add(true);
        }
        else
          {
          //sink.addError('Invalid data');
          sink.add(false);
        }
      }
  );

  //----- notification Validator
  var notificationValidator = StreamTransformer<bool, bool>.fromHandlers(
      handleData: (check, sink)
      {
        if (check == true)
        {
          sink.add(true);
        }
        else
        {
          //sink.addError('Invalid data');
          sink.add(false);
        }
      }
  );

}
