import 'package:seucontrolefinanceiro/src/model/user-model.dart';
import 'package:seucontrolefinanceiro/src/user/user-service.dart';

class UserControler {
  static Future<UserModel> getUser() {
    return UserService.getUser();
  }
}