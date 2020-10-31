import 'package:shared_preferences/shared_preferences.dart';

class Privacy {
  static Future<bool> changeHidden() async {
    var prefs = await SharedPreferences.getInstance();
    bool hidden = prefs.getBool('hidden');
    hidden = !hidden;
    prefs.setBool('hidden', hidden);
    return hidden;
  }

  static Future<bool> getHidden() async {
    var prefs = await SharedPreferences.getInstance();
    bool hidden = prefs.getBool('hidden');

    if (hidden == null) {
      prefs.setBool('hidden', hidden);
      return false;
    }

    return hidden;
  }
}