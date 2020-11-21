import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider {
  static resetPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('type', '');
    prefs.setString('user', '');
    prefs.setString('userId', '');
    prefs.setString('rememberMe', 'false');
  }

  static setRememberMe(bool validation) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('rememberMe', validation.toString());
  }

  static Future<bool> getRemeberMe() async {
    var prefs = await SharedPreferences.getInstance();
    String rememberMe = prefs.getString('rememberMe') ?? '';
    return rememberMe == "true";
  }
}
