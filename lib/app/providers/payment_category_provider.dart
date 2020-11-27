import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';

class PaymentCategoryProvider {
  static Future<List<dynamic>> findAllByBillType(String billType) async {
    var header = await UtilProvider.getHeaderWithAuth();
    var uri = Environment().api(
        endpoint: 'api/v1/payment-categories/descriptions?billType=$billType');
    List<dynamic> descriptions;

    try {
      Response response = await Dio()
          .request(uri.toString(), options: Options(headers: header));

      descriptions = response.data;

      return descriptions;
    } on Exception {
      return descriptions;
    }
  }
}
