import 'package:seucontrolefinanceiro/app/models/domain/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  static Future<int> doLogin({Login login}) async {
    await Future.delayed(Duration(seconds: 3));
    var codeResponse = 204;

    return codeResponse;
  }

  static Future<Login> getLogin() async {
    var prefs = await SharedPreferences.getInstance();
    var login = Login();
    login.user = prefs.getString('user');
    login.password = prefs.getString('password');
    return login;
  }
}
