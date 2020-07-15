import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('text0', style: TextStyle(fontSize: 30),),
              Text('text0', style: TextStyle(fontSize: 30),),
              Text('text0', style: TextStyle(fontSize: 30),),
            ],
          ),
        ),
      ),
    );
  }
}
