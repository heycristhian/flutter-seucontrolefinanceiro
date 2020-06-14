import 'package:seucontrolefinanceiro/src/bill/bill-service.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillController {
  static Future<double> getValueTotalMonth() async {
    
    List<BillModel> bills = await BillService.getBills();
    double _valueTotal = 20;

    print(bills.length);
    bills.forEach((element) {print(element.billDescription);});

    bills.where((element) => element.paid == false)
      .forEach((element) {_valueTotal += double.parse(element.amount);});

      bills.forEach((element) {print(element.amount);});

    return _valueTotal;
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
