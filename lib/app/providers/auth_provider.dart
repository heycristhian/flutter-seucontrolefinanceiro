import 'dart:convert';

import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/models/domain/auth-model.dart';
import 'package:seucontrolefinanceiro/app/models/domain/login.dart';
import 'package:seucontrolefinanceiro/app/models/user-model.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  static Future<int> doLogin({Login login}) async {
    var prefs = await UtilProvider.getPrefs();
    var header = UtilProvider.getHeaderDefault();
    var url = Environment().api(endpoint: 'auth');

    Map params = {"email": login.user, "password": login.password};

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);

    try {
      UserModel user = UserModel();
      Map mapResponse = json.decode(response.body);
      final auth = AuthModel.fromJson(mapResponse);
      AuthProvider.setPrefs(prefs, mapResponse, login, user);
      auth.fullName = prefs.getString('fullname');
      auth.email = prefs.getString('email');
      return response.statusCode;
    } on Exception {
      UtilProvider.resetPrefs();
      AuthModel auth = AuthModel();
      auth.email = 'error';
      return response.statusCode;
    }
  }

  static void setPrefs(prefs, mapResponse, login, user) {
    prefs.setString('token', mapResponse['token']);
    prefs.setString('type', mapResponse['type']);
    prefs.setString('user', login.user);
    prefs.setString('password', login.password);
    prefs.setString('userId', mapResponse['userId']);
    prefs.setString('fullname', user.fullName);
  }

  static Future<Login> getLogin() async {
    var prefs = await SharedPreferences.getInstance();
    var login = Login();
    login.user = prefs.getString('user');
    login.password = prefs.getString('password');
    return login;
  }
}
