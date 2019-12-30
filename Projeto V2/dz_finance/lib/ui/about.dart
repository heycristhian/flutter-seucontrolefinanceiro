import 'package:flutter/material.dart';

import 'about.dart';

class PageAbout extends StatefulWidget {
  @override
  _PageAboutState createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My About Page"),
      ),
      body: Center(
        child: Text("My about page",
        style: TextStyle(fontSize: 40.0)),
      ),
    );
  }
}