import 'package:dio/dio.dart';
import 'package:seucontrolefinanceiro/app/environment/environment.dart';
import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/providers/util_provider.dart';

class PanelProvider {
  static Future<PanelHome> getPanels() async {
    var prefs = await UtilProvider.getPrefs();
    String userId = prefs.getString('userId');
    var header = await UtilProvider.getHeaderWithAuth();
    var uri = Environment().api(endpoint: 'api/v1/panels?userId=$userId');

    var panelHome = PanelHome();

    Response response =
        await Dio().request(uri.toString(), options: Options(headers: header));

    panelHome = PanelHome.fromJson(response.data);
    return panelHome;
  }
}
