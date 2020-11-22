import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/providers/auth_provider.dart';
import 'package:seucontrolefinanceiro/app/providers/splash_screen_provider.dart';

class SplashScreenController {
  static hasLoggedUser(BuildContext context) async {
    bool isToRemember = await SplashScreenProvider.getRemeberMe();

    if (!isToRemember) {
      return Navigator.pushReplacementNamed(context, '/login_page');
    }

    var login = await AuthProvider.getLogin();

    if (login.password != null && login.password != null) {
      var status = await AuthProvider.doLogin(login: login);
      if (status == 200) {
        return Navigator.pushReplacementNamed(context, '/home_page');
      }
    }

    return Navigator.pushReplacementNamed(context, '/login_page');
  }
}
