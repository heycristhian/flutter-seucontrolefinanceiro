import 'package:seucontrolefinanceiro/app/models/bill-model.dart';
import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/providers/bill_provider.dart';
import 'package:seucontrolefinanceiro/app/providers/panel_provider.dart';

class BillsPageController {
  static Future<PanelHome> getPanel() async {
    return PanelProvider.getPanels();
  }

  List<BillModel> currentBillsByType(
      List<BillModel> currentBills, bool isPayment) {
    String billType = isPayment ? 'PAYMENT' : 'RECEIVEMENT';
    return currentBills.where((bill) => bill.billType == billType).toList();
  }

  payBill(BillModel currentBillByType) async {
    currentBillByType.paid = true;
    await BillProvider.updateBill(currentBillByType);
  }
}
