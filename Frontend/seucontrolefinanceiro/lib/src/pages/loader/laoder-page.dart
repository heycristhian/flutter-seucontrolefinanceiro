import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/model/auth-model.dart';
import 'package:seucontrolefinanceiro/src/model/login-model.dart';
import 'package:seucontrolefinanceiro/src/pages/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/pages/loader/loader.dart';
import 'package:seucontrolefinanceiro/src/pages/login/login-page.dart';
import 'package:seucontrolefinanceiro/src/services/login-service.dart';

class LoaderPage extends StatefulWidget {
  LoginModel loginModel;
  LoaderPage(LoginModel loginModel) {
    this.loginModel = loginModel;
  }

  @override
  _LoaderPageState createState() => _LoaderPageState(loginModel);
}

class _LoaderPageState extends State<LoaderPage> {
  LoginModel loginModel;
  _LoaderPageState(loginModel) {
    this.loginModel = loginModel;
  }

  @override
  Widget build(BuildContext context) {
    Future<AuthModel> auth = LoginService.login(loginModel);
    return FutureBuilder(
        future: auth,
        builder: (context, snapshot) {
          AuthModel authModel = AuthModel();
          authModel = snapshot.data;

          print('AUTH ' + snapshot.data.toString());

          if (!snapshot.hasData) {
            return Loader.load();
          }
          if (snapshot.hasError) {
            print('deu erro classe: loader-page');
            return Loader.load();
          } else if (snapshot.hasData && authModel.email == 'error') {
            return LoginPage(false);
          } else {
            return HomePage();
          }
        });
  }
}
