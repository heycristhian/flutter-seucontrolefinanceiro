import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';

class Bill {
  String id;
  String billDescription;
  int amount;
  bool everyMonth;
  bool sameAmount;
  String payDAy;
  String billType;
  PaymentCategory paymentCategory;
  bool paid;
  String parent;
  String userId;

  Bill(
      {this.id,
      this.billDescription,
      this.amount,
      this.everyMonth,
      this.sameAmount,
      this.payDAy,
      this.billType,
      this.paymentCategory,
      this.paid,
      this.parent,
      this.userId});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billDescription = json['billDescription'];
    amount = json['amount'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    return data;
  }
}