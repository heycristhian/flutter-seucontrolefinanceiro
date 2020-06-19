import 'dart:convert';

import 'package:seucontrolefinanceiro/src/global/url-global.dart';
import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentCategoryService {
  static Future<List<PaymentCategory>> getPaymentCategories() async {
    var url = UrlGlobal.url() + '/scf-service/payment-categories';
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String tokenType = prefs.getString('type') ?? '';

    var header = {
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      List listResponse = json.decode(response.body);

      final paymentCategories = List<PaymentCategory>();

      try {
        for (Map map in listResponse) {
          PaymentCategory p = PaymentCategory.fromJson(map);
          paymentCategories.add(p);
        }
      } on Exception {
        print('Sem pagamentos');
      }

      return paymentCategories;
    } else {
      throw Exception;
    }
  }
}
