import 'package:dz_finance/ui/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "DZ-Finance",
    theme: ThemeData(
        primaryColor: Color.fromRGBO(17, 199, 111, 1),
        primaryColorDark: Color.fromRGBO(18, 18, 18, 1)),
    home: Home(),
  ));
}
