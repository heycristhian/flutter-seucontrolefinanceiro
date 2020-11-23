import 'dart:convert';

import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';
import 'package:http/http.dart' as http;

class PanelProvider {
  static Future<PanelHome> getPanels() async {
    var prefs = await UtilProvider.getPrefs();
    String userId = prefs.getString('userId');
    var header = await UtilProvider.getHeaderWithAuth();
    var uri = Environment().api(endpoint: 'api/v1/panels?userId=$userId');

    var panelHome = PanelHome();
    var response = await http.get(uri, headers: header);

    print('response.statusCode');
    print(response.statusCode);

    if (response.statusCode == 200) {
      var currentResponse = json.decode(response.body);

      try {
        panelHome = PanelHome.fromJson(currentResponse);
      } on Exception {
        print('Sem users!');
      }
    }
    print('panelHome');
    print(panelHome.toJson());
    return panelHome;
  }
}
