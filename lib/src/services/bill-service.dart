import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/app/environment/environment.dart';
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

    var url = Environment().api(endpoint: 'scf-service/users/$user/bills');

    Response response =
        await Dio().request(url.toString(), options: Options(headers: header));

    List<BillModel> bills = List<BillModel>();

    for (Map<String, dynamic> item in response.data) {
      bills.add(BillModel.fromJson(item));
    }
    return bills;
  }

  static Future<BillModel> insertBill(BillModel billModel) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var url = Environment().api(endpoint: 'scf-service/bills');

    Map params = {
      "billDescription": billModel.billDescription,
      "amount": billModel.amount,
      "everyMonth": billModel.everyMonth,
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

    var response = await http.post(url, headers: header, body: _body);
  }

  static Future<BillModel> updateBill(BillModel billModel) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var url = Environment().api(endpoint: 'scf-service/bills');

    Map params = {
      "id": billModel.id,
      "billDescription": billModel.billDescription,
      "amount": billModel.amount,
      "everyMonth": billModel.everyMonth,
      "payDAy": billModel.payDAy,
      "billType": billModel.billType,
      "paymentCategory": {
        "description": billModel.paymentCategory.description,
        "mutable": true,
        "billType": billModel.paymentCategory.billType
      },
      "paid": billModel.paid == null ? false : billModel.paid,
      "userId": billModel.userId,
      "parentId": billModel.parentId,
      "portion": billModel.portion,
      "paidIn": billModel.paidIn,
    };

    var _body = json.encode(params);

    var response = await http.put(url, headers: header, body: _body);
  }

  static Future<void> deleteBill(String id) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var url = Environment().api(endpoint: 'scf-service/bills/$id');

    var response = await http.delete(url, headers: header);
  }
}
