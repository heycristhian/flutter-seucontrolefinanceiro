import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seucontrolefinanceiro/src/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/loader/loader.dart';
import 'package:seucontrolefinanceiro/src/login/login-page.dart';
import 'package:seucontrolefinanceiro/src/login/login-service.dart';
import 'package:seucontrolefinanceiro/src/model/auth-model.dart';
import 'package:seucontrolefinanceiro/src/model/login-model.dart';

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
    print('Loader: ' + this.loginModel.user);
    Future<AuthModel> auth = LoginService.login(loginModel);
    return FutureBuilder(
        future: auth,
        builder: (context, snapshot) {
          AuthModel authModel = AuthModel();
          authModel = snapshot.data;

          print('AUTH ' + snapshot.data.toString());
          
          if(!snapshot.hasData) {
            return Loader.load();
          }
          if (snapshot.hasError) {
            print('deu erro classe: loader-page');
            Loader.load();
          } else if (snapshot.hasData && authModel.email == 'error') {
            return LoginPage();
          } else {
            return HomePage();
          }

        });
  }
}
