import 'package:seucontrolefinanceiro/app/models/bill-model.dart';
import 'package:seucontrolefinanceiro/app/providers/bill_provider.dart';

class TimeLineController {
  static Future<int> undoBillPaid(BillModel bill) async {
    bill.paid = !bill.paid;
    await BillProvider.updateBill(bill);
    return 204;
  }
}
