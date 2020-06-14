class AuthModel {
  String token;
  String type;
  String userId;

  AuthModel({this.token, this.type, this.userId});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    data['userId'] = this.userId;
    return data;
  }
}