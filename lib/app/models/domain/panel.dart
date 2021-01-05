import 'package:seucontrolefinanceiro/app/models/bill-model.dart';

class Panel {
  String date;
  int year;
  var amount;
  String title;
  List<BillModel> bills;

  Panel({this.date, this.year, this.amount, this.title, this.bills});

  Panel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    year = json['year'];
    amount = json['amount'];
    title = json['title'];
    if (json['bills'] != null) {
      bills = new List<BillModel>();
      json['bills'].forEach((v) {
        bills.add(BillModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['year'] = this.year;
    data['amount'] = this.amount;
    data['title'] = this.title;
    if (this.bills != null) {
      data['bills'] = this.bills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
