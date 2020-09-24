import 'dart:async';
import 'package:fiftyoneeast/models/login_respmodel.dart';
import 'package:fiftyoneeast/models/login_rqstmodel.dart';
import 'package:fiftyoneeast/networking/response.dart';
import 'package:fiftyoneeast/repository/FiftyOneEastRepository.dart';
import 'package:fiftyoneeast/util/Validators.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with Validators
{
  //StreamController loginController;
  //final loginFetcher = BehaviorSubject<Response<LoginResponseModel>>();
  FiftyOneEastRepository api;

  //StreamController<Response<LoginResponseModel>> loginFetcher = new BehaviorSubject();
  StreamController loginFetcher = new BehaviorSubject<Response<LoginResponseModel>>();
  final mobileController =  BehaviorSubject<String>();
  final passwordController =  BehaviorSubject<String>();


  LoginBloc()
  {
    api = new FiftyOneEastRepository();
    //loginController = StreamController<Response<LoginResponseModel>>();
   }

  Function(String) get mobileChange =>mobileController.sink.add;
  Function(String) get passwordChanged => passwordController.sink.add;

  Stream<String> get mobile => mobileController.stream.transform(mobileValidator);
  Stream<String> get password => passwordController.stream.transform(passwordValidator);

  Stream<bool> get loginCheck => Rx.combineLatest2(mobile, password, (m, p)=>true);

  Stream<Response<LoginResponseModel>> get loginDetailsStream => loginFetcher.stream;


  getAllLoginData(BuildContext context) async
  {
    if(loginFetcher.isClosed)
      {
        //loginFetcher = new BehaviorSubject();
        loginFetcher = new BehaviorSubject<Response<LoginResponseModel>>();
      }

    try
    {
      LoginRequestModel request = new LoginRequestModel();
      request.username = mobileController.value;
      request.password = passwordController.value;
      LoginResponseModel loginResponseModel = await api.login(request);
      loginFetcher.sink.add(Response.completed(loginResponseModel));
    }
    catch (e)
    {
      loginFetcher.sink.add(Response.error(e.toString()));
      print(e);
    }
    finally
    {
      loginFetcher.close();
    }
  }

  dispose()
  {
    //loginController?.close();
    mobileController?.close();
    passwordController?.close();
    loginFetcher?.close();
  }

}
