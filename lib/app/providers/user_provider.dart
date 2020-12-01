import 'dart:convert';

import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/models/user-model.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static Future<UserModel> getUser() async {
    var prefs = await UtilProvider.getPrefs();
    String userId = prefs.getString('userId');
    var header = await UtilProvider.getHeaderWithAuth();
    var uri = Environment().api(endpoint: 'api/v1/users/$userId');
    var user = UserModel();

    var response = await http.get(uri, headers: header);

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
