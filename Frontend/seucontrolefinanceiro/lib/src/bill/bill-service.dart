import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/src/global/url-global.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillService {
  static Future<List<BillModel>> getBills() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';
    String user = prefs.getString('user') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var url = UrlGlobal.url() + '/scf-service/users/$user/bills';

    //AQUI

    Response response =
        await Dio().request(url.toString(), options: Options(headers: header));

    List<BillModel> bills = List<BillModel>();

    for (Map<String, dynamic> item in response.data) {
      bills.add(BillModel.fromJson(item));
    }

    return bills;
    //ATE AQUI

    /*
    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      List listResponse = json.decode(response.body);

      final bills = List<BillModel>();

      try {
        for (Map map in listResponse) {
          BillModel b = BillModel.fromJson(map);
          bills.add(b);
        }
      } on Exception {
        print('Sem contas!');
      }

      return bills;
    } else {
      throw Exception;
    }*/
  }

  static Future<BillModel> insertBill(BillModel billModel) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var url = UrlGlobal.url() + '/scf-service/bills';

    Map params = {
      "billDescription": billModel.billDescription,
      "amount": billModel.amount,
      "everyMonth": billModel.everyMonth,
      "sameAmount": billModel.sameAmount,
      "payDAy": billModel.payDAy,
      "billType": billModel.billType,
      "paymentCategory": {
        "description": billModel.paymentCategory.description,
        "mutable": true,
        "billType": billModel.paymentCategory.billType
      },
      "paid": false,
      "userId": billModel.userId,
      "portion": billModel.portion,
    };

    var _body = json.encode(params);
    print('Json enviado (insertBill) $_body');

    var response = await http.post(url, headers: header, body: _body);

    print('Status code inserBill: ${response.statusCode}');
  }
}
