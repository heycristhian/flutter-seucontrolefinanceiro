import 'package:seucontrolefinanceiro/app/models/payment-category-model.dart';

class BillModel {
  String id;
  String billDescription;
  String amount;
  bool everyMonth;
  String payDAy;
  String billType;
  PaymentCategoryModel paymentCategory;
  bool paid;
  String parentId;
  String userId;
  String sClass;
  int portion;
  String paidIn;

  BillModel(
      {this.id,
      this.billDescription,
      this.amount,
      this.everyMonth,
      this.payDAy,
      this.billType,
      this.paymentCategory,
      this.paid,
      this.parentId,
      this.userId,
      this.sClass,
      this.portion,
      this.paidIn});

  BillModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      billDescription = json['billDescription'];
      amount = json['amount'].toString();
      everyMonth = json['everyMonth'];
      payDAy = json['payDAy'];
      billType = json['billType'];
      paymentCategory = json['paymentCategory'] != null
          ? new PaymentCategoryModel.fromJson(json['paymentCategory'])
          : null;
      paid = json['paid'];
      parentId = json['parent'];
      userId = json['userId'];
      sClass = json['_class'];
      portion = json['portion'];
      id = json['id'];
      paidIn = json['paidIn'];
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
    data['parent'] = this.parentId;
    data['userId'] = this.userId;
    data['_class'] = this.sClass;
    data['portion'] = this.portion;
    data['id'] = this.id;
    data['paidIn'] = this.paidIn;
    return data;
  }
}
