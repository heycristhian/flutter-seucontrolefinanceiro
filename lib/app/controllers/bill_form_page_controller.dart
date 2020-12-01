import 'package:seucontrolefinanceiro/app/providers/bill_provider.dart';

class BillFormPageController {
  static Future<int> handleSaveBill(bill) async {
    bill.payDAy = bill.payDAy.substring(0, 10);
    bill.paymentCategory.billType = bill.billType;
    int status = await BillProvider.save(bill);
    return status;
  }
}
