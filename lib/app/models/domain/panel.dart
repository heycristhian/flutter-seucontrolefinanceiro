class Panel {
  String title;
  int year;
  int amount;

  Panel({this.title, this.year, this.amount});

  Panel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['year'] = this.year;
    data['amount'] = this.amount;
    return data;
  }
}
