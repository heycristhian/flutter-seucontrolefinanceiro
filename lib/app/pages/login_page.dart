import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: TextStyle(color: Colors.white),
      child: Container(
        color: Colors.red,
        child: Center(
          child: Text('LOGIN PAGE'),
        ),
      ),
    );
  }
}
