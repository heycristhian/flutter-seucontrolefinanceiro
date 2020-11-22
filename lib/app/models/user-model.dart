import 'package:seucontrolefinanceiro/app/models/bill-model.dart';

class UserModel {
  String id;
  String fullName;
  String email;
  String cpf;
  List<BillModel> bills;

  UserModel({this.id, this.fullName, this.email, this.cpf, this.bills});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    cpf = json['cpf'];
    if (json['bills'] != null) {
      bills = new List<BillModel>();
      json['bills'].forEach((v) {
        bills.add(new BillModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    if (this.bills != null) {
      data['bills'] = this.bills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
