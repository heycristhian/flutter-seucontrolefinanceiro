import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu controle financeiro',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}