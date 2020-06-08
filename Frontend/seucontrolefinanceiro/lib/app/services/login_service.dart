import 'package:http/http.dart' as http;

class LoginService {

 Future<bool> checkLogin(String user, String password) async {
   http.Response response;
   response = await http.get('http://192.168.0.148:8080/scf-service/users/authUser?user=${user}&password=${password}');
   print(response.statusCode.toString());
   if (response.statusCode.toString() == '200') {
     return true;
   } else {
     return false;
   }
 } 
}