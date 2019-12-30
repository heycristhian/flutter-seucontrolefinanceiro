import 'package:flutter/material.dart';

class PageAbout extends StatefulWidget {
  @override
  _PageAboutState createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Center(
        child: Text("Page About!!!", style: TextStyle(fontSize: 50.0),),
      ),
    );
  }
}
