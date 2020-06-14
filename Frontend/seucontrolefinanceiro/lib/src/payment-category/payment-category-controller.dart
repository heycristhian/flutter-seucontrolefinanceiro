import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';
import 'package:seucontrolefinanceiro/src/payment-category/payment-category-service.dart';

class PaymentCategoryController {

  static Future<List<PaymentCategory>> getPaymentCategories() async {
      return await PaymentCategoryService.getPaymentCategories();
  }

  static getPaymentReceivement() {
    var receivement = [
      'Empréstimo',
      'Salário',
      'Investimento',
      'Outras'
    ];

    return receivement;
  }
}