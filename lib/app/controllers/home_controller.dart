import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/models/user-model.dart';
import 'package:seucontrolefinanceiro/app/providers/user_provider.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';

class HomeController {
  static void logout(context) {
    UtilProvider.resetPrefs();
    Navigator.of(context).pushReplacementNamed('/login_page');
  }

  static Future<UserModel> getUser() async {
    return UserProvider.getUser();
  }
}
