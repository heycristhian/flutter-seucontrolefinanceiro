import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/model/login-model.dart';
import 'package:seucontrolefinanceiro/src/model/remember-me.dart';
import 'package:seucontrolefinanceiro/src/pages/loader/laoder-page.dart';
import 'package:seucontrolefinanceiro/src/pages/login/login-page.dart';
import 'package:seucontrolefinanceiro/src/services/login-service.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockCheckForSession().then((RememberMe result) {
      if (result.rememberMe == 'true') {
        LoginModel loginModel = LoginModel();
        loginModel.user = result.user;
        loginModel.password = result.password;
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (BuildContext context) => LoaderPage(loginModel)));
      } else {
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (BuildContext context) => LoginPage(true)));
      }
    });
  }

  Future<RememberMe> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    RememberMe rememberMe = await LoginService.getRemeberMe();
    return rememberMe;
  }

  Future<RememberMe> rememberMeFuture = LoginService.getRemeberMe();

  @override
  Widget build(BuildContext context) {
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
