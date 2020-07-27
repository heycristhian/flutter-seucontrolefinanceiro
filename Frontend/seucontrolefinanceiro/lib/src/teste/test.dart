import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
        body: LiquidLinearProgressIndicator(
          value: 0.8, // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(
              Colors.pink), // Defaults to the current Theme's accentColor.
          backgroundColor:
              Colors.white, // Defaults to the current Theme's backgroundColor.
          borderColor: Colors.red,
          borderWidth: 0.0,
          borderRadius: 12.0,
          direction: Axis
              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
          center: Text("Loading..."),
        ));
  }

  _testWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ProgressButton(
        progressWidget: const CircularProgressIndicator(),
        width: 100,
        height: 40,
        color: Colors.red,
        //Color.fromRGBO(17, 199, 111, 1),
        onPressed: () async {
          int score = await Future.delayed(
              const Duration(milliseconds: 1000), () => 42);
          // After [onPressed], it will trigger animation running backwards, from end to beginning
          return () async {};
        },
        defaultWidget: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }
}
