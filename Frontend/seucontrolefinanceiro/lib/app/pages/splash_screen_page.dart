import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/controllers/splash_screen_controller.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    SplashScreenController.hasLoggedUser(context);
    return _loadSplashScreen();
  }

  Widget _loadSplashScreen() {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                    Colors.greenAccent,
                    Colors.green,
                  ])),
            ),
            SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              width: 200,
              height: 200,
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Colors.white,
              highlightColor: Colors.blue[600],
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "CONTROLE FINANCEIRO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.w700,
                          shadows: <Shadow>[
                            Shadow(
                                blurRadius: 18.0,
                                color: Colors.black87,
                                offset: Offset.fromDirection(120, 12))
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
