import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/providers/auth_provider.dart';
import 'package:seucontrolefinanceiro/app/providers/splash_screen_provider.dart';

class SplashScreenController {
  static hasLoggedUser(BuildContext context) async {
    bool isToRemember = await SplashScreenProvider.getRemeberMe();
    var login = await AuthProvider.getLogin();
    var status = await AuthProvider.doLogin(login: login);

    if (isToRemember && status == 204) {
      Navigator.pushReplacementNamed(context, '/home_page');
    } else {
      SplashScreenProvider.resetPrefs();
      Navigator.pushReplacementNamed(context, '/login_page');
    }
  }
}
