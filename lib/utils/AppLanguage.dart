import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier
{
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  // fetch the locale from the SharedPreferences whenever the app loads for the first time
  fetchLocale() async
  {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null)
    {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  // Calling changeLanguage() from anywhere in the app to change the locale and store it in SharedPreferences .
  void changeLanguage(Locale type) async
  {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type)
    {
      return;
    }
    if (type == Locale("ar"))
    {
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    }
    else
      {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}