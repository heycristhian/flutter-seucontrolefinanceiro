import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Icon(
              Icons.menu,
              color: Colors.white,
            )
          ],
          title: Text(
            'AppBar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container());
  }

}
