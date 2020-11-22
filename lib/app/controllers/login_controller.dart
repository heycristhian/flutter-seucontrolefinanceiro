import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/models/domain/login.dart';
import 'package:seucontrolefinanceiro/app/providers/auth_provider.dart';

class LoginController {
  static void doLogin({Login login, BuildContext context}) async {
    login.password = login.password.trim();
    login.user = login.user.trim();

    AuthProvider.doLogin(login: login).then((value) => {
          if (value == 200)
            {Navigator.of(context).pushNamed('/home_page')}
          else
            {Navigator.of(context).pushNamed('/login_page')}
        });
    Navigator.of(context).pushNamed('/loader_page');
  }
}
