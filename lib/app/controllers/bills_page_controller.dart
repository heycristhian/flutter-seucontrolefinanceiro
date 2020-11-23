import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/providers/panel_provider.dart';

class BillsPageController {
  static Future<PanelHome> getPanel() async {
    return PanelProvider.getPanels();
  }
}
