import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';

class PaymentCategoryProvider {
  static Future<List<String>> findAllByBillType(String billType) async {
    var header = await UtilProvider.getHeaderWithAuth();
    var uri = Environment().api(
        endpoint: 'api/v1/payment-categories/descriptions?billType=$billType');
    List<String> descriptions = [];

    try {
      Response response = await Dio()
          .request(uri.toString(), options: Options(headers: header));

      for (var item in response.data) {
        descriptions.add(item);
      }
      return descriptions;
    } on Exception {
      return descriptions;
    }
  }
}
