
import 'package:flutter/material.dart';
import 'package:mini_git_dashboard/ui/login_view.dart';
import 'package:mini_git_dashboard/ui/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  static late SharedPreferences _preferences;
  static Future<void> initAppData() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool isUserLoggedIn(){
    return _preferences.getBool('logged-in') ?? false;
  }

  static bool isLightMode(){
    return _preferences.getBool('light-mode') ?? true;
  }

  static Future<void> setLightMode(bool value) async {
    await _preferences.setBool('light-mode', value);
  }

  static Widget getView(){
    return isUserLoggedIn() ? HomeView() : LoginView();
  }

  static Future<void> setLoggedIn(bool value) async {
    await _preferences.setBool('logged-in', value);
  }

  static Future<void> saveOAuthToken(String token) async {
    await _preferences.setString('token', token);
  }

  static String getOAuthToken() {
    return _preferences.getString('token') as String;
  }
}



