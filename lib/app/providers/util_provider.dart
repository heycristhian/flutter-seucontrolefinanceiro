import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UtilProvider {
  static resetPrefs() async {
    var prefs = await UtilProvider.getPrefs();
    prefs.setString('token', '');
    prefs.setString('type', '');
    prefs.setString('user', '');
    prefs.setString('userId', '');
    prefs.setString('rememberMe', 'false');
  }

  static setRememberMe(bool validation) async {
    var prefs = await UtilProvider.getPrefs();
    prefs.setString('rememberMe', validation.toString());
  }

  static getHeaderDefault() {
    var header = {"Content-Type": "application/json"};
    return header;
  }

  static getHeaderWithAuth() async {
    var prefs = await UtilProvider.getPrefs();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';
    return {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };
  }

  static getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static getToken() async {
    var prefs = await UtilProvider.getPrefs();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';
    return '$tokenType $token';
  }
}
