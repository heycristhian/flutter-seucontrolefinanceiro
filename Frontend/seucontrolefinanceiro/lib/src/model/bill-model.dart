import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';

class BillModel {
  String id;
  String billDescription;
  String amount;
  bool everyMonth;
  String payDAy;
  String billType;
  PaymentCategory paymentCategory;
  bool paid;
  String parent;
  String userId;
  String sClass;
  int portion;

  BillModel(
      {this.id,
      this.billDescription,
      this.amount,
      this.everyMonth,
      this.payDAy,
      this.billType,
      this.paymentCategory,
      this.paid,
      this.parent,
      this.userId,
      this.sClass,
      this.portion});

  BillModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      billDescription = json['billDescription'];
      var test = json['amount'];
      print(test);
      amount = json['amount'].toString();
      everyMonth = json['everyMonth'];
      payDAy = json['payDAy'];
      billType = json['billType'];
      paymentCategory = json['paymentCategory'] != null
          ? new PaymentCategory.fromJson(json['paymentCategory'])
          : null;
      paid = json['paid'];
      parent = json['parent'];
      userId = json['userId'];
      sClass = json['_class'];
      portion = json['portion'];
      id = json['id'];
    } else {
      print('Bill null');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billDescription'] = this.billDescription;
    data['amount'] = this.amount;
    data['everyMonth'] = this.everyMonth;
    data['payDAy'] = this.payDAy;
    data['billType'] = this.billType;
    if (this.paymentCategory != null) {
      data['paymentCategory'] = this.paymentCategory.toJson();
    }
    data['paid'] = this.paid;
    data['parent'] = this.parent;
    data['userId'] = this.userId;
    data['_class'] = this.sClass;
    data['portion'] = this.portion;
    data['id'] = this.id;
    return data;
  }
}
