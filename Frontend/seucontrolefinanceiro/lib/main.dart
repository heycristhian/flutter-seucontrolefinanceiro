import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/login/login-page.dart';

void main() {
  runApp(MaterialApp(
    title: "Seu controle financeiro",
    theme: ThemeData(
        primaryColor: Color.fromRGBO(17, 199, 111, 1),
        primaryColorDark: Color.fromRGBO(18, 18, 18, 1)),
    home: LoginPage(),
  ));
}