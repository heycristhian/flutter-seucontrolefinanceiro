import 'package:flutter/material.dart';

class MyAppBar {
  Widget myAppBar() {
    return Material(
        elevation: 10.0,
        child: Container(
          height: 180,
          color: Color.fromRGBO(17, 199, 111, 1),
          padding: EdgeInsets.all(0),
        ));
  }
}
