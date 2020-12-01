class PaymentCategoryModel {
  String id;
  String description;
  bool mutable;
  String billType;

  PaymentCategoryModel(
      {this.id, this.description, this.mutable, this.billType});

  PaymentCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    mutable = json['mutable'];
    billType = json['billType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['mutable'] = this.mutable;
    data['billType'] = this.billType;
    return data;
  }
}
