import 'dart:convert';

import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillService {
  static Future<List<Bill>> getBills() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';
    String user = prefs.getString('user') ?? '';
    print('Token em bill service: ' + token);

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };
    var url = 'http://192.168.0.148:8080/scf-service/users/$user/bills';
    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      List listResponse = json.decode(response.body);

      final bills = List<Bill>();

      for (Map map in listResponse) {
        Bill b = Bill.fromJson(map);
        bills.add(b);
      }
      return bills;
    } else {
      throw Exception;
    }
  }
}
