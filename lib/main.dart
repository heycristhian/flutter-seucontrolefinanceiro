import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/pages/home/home_page.dart';
import 'package:seucontrolefinanceiro/app/pages/loader/loader_page.dart';
import 'package:seucontrolefinanceiro/app/pages/login/login_page.dart';

import 'app/pages/splash_screen_page.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Seu controle financeiro",
      theme: ThemeData(
          primaryColor: Color.fromRGBO(17, 199, 111, 1),
          primaryColorDark: Color.fromRGBO(18, 18, 18, 1)),
      //home: SplashScreen(),
      routes: {
        '/splash_screen_page': (context) => SplashScreenPage(),
        '/home_page': (context) => HomePage(),
        '/login_page': (context) => LoginPage(),
        '/loader_page': (context) => LoaderPage(),
      },
      initialRoute: '/splash_screen_page',
    );
  }
}
