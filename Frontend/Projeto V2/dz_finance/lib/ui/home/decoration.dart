import 'package:flutter/material.dart';

abstract class Decoracao {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, .125)),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)));
  }
}
