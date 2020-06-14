import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';

class BillModel {
  String billDescription;
  String amount;
  bool everyMonth;
  bool sameAmount;
  String payDAy;
  String billType;
  PaymentCategory paymentCategory;
  bool paid;
  String parent;
  String userId;
  String sClass;

  BillModel(
      {this.billDescription,
      this.amount,
      this.everyMonth,
      this.sameAmount,
      this.payDAy,
      this.billType,
      this.paymentCategory,
      this.paid,
      this.parent,
      this.userId,
      this.sClass});

  BillModel.fromJson(Map<String, dynamic> json) {
    billDescription = json['billDescription'];
    var test = json['amount'];
    print(test);
    amount =  json['amount'].toString();
    everyMonth = json['everyMonth'];
    sameAmount = json['sameAmount'];
    payDAy = json['payDAy'];
    billType = json['billType'];
    paymentCategory = json['paymentCategory'] != null
        ? new PaymentCategory.fromJson(json['paymentCategory'])
        : null;
    paid = json['paid'];
    parent = json['parent'];
    userId = json['userId'];
    sClass = json['_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billDescription'] = this.billDescription;
    data['amount'] = this.amount;
    data['everyMonth'] = this.everyMonth;
    data['sameAmount'] = this.sameAmount;
    data['payDAy'] = this.payDAy;
    data['billType'] = this.billType;
    if (this.paymentCategory != null) {
      data['paymentCategory'] = this.paymentCategory.toJson();
    }
    data['paid'] = this.paid;
    data['parent'] = this.parent;
    data['userId'] = this.userId;
    data['_class'] = this.sClass;
    return data;
  }
}