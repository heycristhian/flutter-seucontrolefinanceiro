import 'package:seucontrolefinanceiro/src/bill/bill-service.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class BillController {
  static Future<double> getValueTotalMonth() async {
    
    List<Bill> bills = await BillService.getBills();
    double _valueTotal = 0;

    bills.where((element) => element.paid == false)
      .forEach((element) {_valueTotal += element.amount;});

      bills.forEach((element) {print(element.amount);});

    return _valueTotal;
  }
}
