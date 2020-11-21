import 'package:seucontrolefinanceiro/src/model/user-model.dart';
import 'package:seucontrolefinanceiro/src/services/user-service.dart';

class UserControler {
  static Future<UserModel> getUser() {
    return UserService.getUser();
  }
}