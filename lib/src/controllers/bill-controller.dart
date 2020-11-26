import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';
import 'package:seucontrolefinanceiro/src/services/bill-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillController {
  static Future<List<BillModel>> getBillsByCurrentUser() async {
    List<BillModel> bills = await BillService.getBills();
    return bills;
  }

  static insertBill(BillModel billModel, String currentCategory) async {
    var paymentCategory = PaymentCategory();
    var prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';

    paymentCategory.description = currentCategory;
    paymentCategory.billType = billModel.billType;

    paymentCategory.billType =
        (paymentCategory.billType == 'Recebimento') ? 'RECEIVEMENT' : 'PAYMENT';
    paymentCategory.mutable = false;
    billModel.paymentCategory = paymentCategory;
    billModel.userId = userId;
    billModel.payDAy = billModel.payDAy.substring(0, 10);

    BillService.insertBill(billModel);
  }

  static updateBill(BillModel billModel, String currentCategory) async {
    var prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? '';

    if (billModel.paid) {
      billModel.paidIn = DateTime.now().toString().substring(0, 10);
    }

    var paymentCategory = PaymentCategory();
    paymentCategory.description = currentCategory;
    paymentCategory.billType = billModel.billType;

    paymentCategory.billType =
        (paymentCategory.billType == 'Recebimento') ? 'RECEIVEMENT' : 'PAYMENT';
    paymentCategory.mutable = false;

    billModel.paymentCategory = paymentCategory;
    billModel.userId = userId;
    billModel.payDAy = billModel.payDAy.substring(0, 10);

    BillService.updateBill(billModel);
  }

  static deleteBill(String id) async {
    BillService.deleteBill(id);
  }
}
