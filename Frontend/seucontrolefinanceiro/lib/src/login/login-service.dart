import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seucontrolefinanceiro/src/global/url-global.dart';
import 'package:seucontrolefinanceiro/src/model/auth-model.dart';
import 'package:seucontrolefinanceiro/src/model/login-model.dart';
import 'package:seucontrolefinanceiro/src/model/remember-me.dart';
import 'package:seucontrolefinanceiro/src/model/user-model.dart';
import 'package:seucontrolefinanceiro/src/user/user-controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<AuthModel> login(LoginModel loginModel) async {
    var url =
        UrlGlobal.url() + '/auth';

    var prefs = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};

    Map params = {"email": loginModel.user, "password": loginModel.password};

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);

    print('Response status: ${response.statusCode}');

    try {
      UserModel user = await UserControler.getUser();
      Map mapResponse = json.decode(response.body);
      final auth = AuthModel.fromJson(mapResponse);
      prefs.setString('token', mapResponse['token']);
      prefs.setString('type', mapResponse['type']);
      prefs.setString('user', loginModel.user);
      prefs.setString('password', loginModel.password);
      prefs.setString('userId', mapResponse['userId']);
      prefs.setString('fullname', user.fullName);
      auth.fullName = prefs.getString('fullname');
      auth.email = prefs.getString('email');
      return auth;
    } on Exception {
      resetPrefs();
      AuthModel auth = AuthModel();
      auth.email = 'error';
      return auth;
    }
  }

  static resetPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('type', '');
    prefs.setString('user', '');
    prefs.setString('userId', '');
    prefs.setString('rememberMe', '');
  }

  static setRememberMe(bool validation) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberMe', validation.toString());
  }

  static Future<RememberMe> getRemeberMe() async {
    var prefs = await SharedPreferences.getInstance();
    RememberMe rememberMe = RememberMe();
    rememberMe.rememberMe = prefs.getString('rememberMe') ?? '';
    rememberMe.user = prefs.getString('user') ?? '';
    rememberMe.password = prefs.getString('password') ?? '';
    return rememberMe;
  }

}
