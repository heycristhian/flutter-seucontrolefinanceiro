import 'package:shared_preferences/shared_preferences.dart';

class Privacy {
  static Future<bool> hidden() async {
    var prefs = await SharedPreferences.getInstance();
    bool hidden = prefs.getBool('hidden');
    hidden = !(hidden == null || hidden != false);
    prefs.setBool('hidden', hidden);
    return hidden;
  }
}