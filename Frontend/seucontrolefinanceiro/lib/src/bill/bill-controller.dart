import 'package:seucontrolefinanceiro/src/bill/bill-service.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillController {
  static Future<List<BillModel>> getBillsByCurrentUser() async {
    List<BillModel> bills = await BillService.getBills();

    print("Tamanho da lista de bills " + bills.length.toString());

    return bills;
  }

  static insertBill(BillModel billModel) async {
    var paymentCategory = PaymentCategory();
    var prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';
    print(userId);

    paymentCategory.description = 'Banco';
    paymentCategory.mutable = true;
    paymentCategory.billType = 'PAYMENT';

    billModel.paymentCategory = paymentCategory;
    billModel.userId = userId;
    billModel.payDAy = billModel.payDAy.substring(0, 10);

    BillService.insertBill(billModel);
  }
}
