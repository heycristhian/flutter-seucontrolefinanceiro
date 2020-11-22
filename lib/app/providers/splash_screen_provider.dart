import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';

class SplashScreenProvider {
  static Future<bool> getRemeberMe() async {
    var prefs = await UtilProvider.getPrefs();
    String rememberMe = prefs.getString('rememberMe') ?? '';
    return rememberMe == "true";
  }
}
