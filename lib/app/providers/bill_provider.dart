import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/models/bill-model.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';

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
}
