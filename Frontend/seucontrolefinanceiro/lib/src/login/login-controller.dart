class LoginController {
  String checkLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o usuário';
    }
    return null;
  }

  String checkPassword(String text) {
    if (text.isEmpty) {
      return 'Digite a senha';
    }
    return null;
  }

  
}
