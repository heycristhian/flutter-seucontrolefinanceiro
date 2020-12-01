import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/models/bill-model.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';
import 'package:http/http.dart' as http;

class BillProvider {
  static Future<List<BillModel>> getBills({isPaid}) async {
    var prefs = await UtilProvider.getPrefs();
    String userId = prefs.getString('userId');
    var header = await UtilProvider.getHeaderWithAuth();
    var uri = Environment()
        .api(endpoint: 'api/v1/bills/paid?userId=$userId&isPaid=$isPaid');
    List<BillModel> bills = List<BillModel>();

    try {
      Response response = await Dio()
          .request(uri.toString(), options: Options(headers: header));

      for (Map<String, dynamic> item in response.data) {
        bills.add(BillModel.fromJson(item));
      }
      return bills;
    } on Exception {
      return bills;
    }
  }

  static updateBill(BillModel billModel) async {
    var header = await UtilProvider.getHeaderWithAuth();
    var url = Environment().api(endpoint: 'api/v1/bills');

    Map params = BillProvider.createParam(billModel);

    var _body = json.encode(params);

    var response = await http.put(url, headers: header, body: _body);
    print(response.statusCode);
  }

  static Map createParam(billModel) {
    return {
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
  }

  static Future<int> save(BillModel billModel) async {
    var header = await UtilProvider.getHeaderWithAuth();
    var prefs = await UtilProvider.getPrefs();
    var userId = prefs.getString('userId');
    var url = Environment().api(endpoint: 'api/v1/bills');

    Map params = {
      "billDescription": billModel.billDescription,
      "amount": billModel.amount,
      "everyMonth": billModel.everyMonth,
      "payDAy": billModel.payDAy,
      "billType": billModel.billType,
      "paymentCategory": {
        "description": billModel.paymentCategory.description,
        "billType": billModel.paymentCategory.billType
      },
      "paid": false,
      "userId": userId,
      "portion": billModel.portion,
    };

    var _body = json.encode(params);

    var response = await http.post(url, headers: header, body: _body);

    return response.statusCode;
  }
}
