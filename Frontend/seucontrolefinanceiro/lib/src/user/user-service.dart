import 'dart:convert';

import 'package:seucontrolefinanceiro/src/global/url-global.dart';
import 'package:seucontrolefinanceiro/src/model/user-model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<UserModel> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';
    String userId = prefs.getString('userId') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var url = UrlGlobal.url() + '/scf-service/users/' + userId;

    var user = UserModel();

    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      var currentResponse = json.decode(response.body);

      try {
        user = UserModel.fromJson(currentResponse);
      } on Exception {
        print('Sem users!');
      }
    }
    return user;
  }
}
