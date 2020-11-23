import 'package:seucontrolefinanceiro/app/models/domain/panel.dart';

class PanelHome {
  int panelQuantity;
  List<Panel> panels;

  PanelHome({this.panelQuantity, this.panels});

  PanelHome.fromJson(Map<String, dynamic> json) {
    panelQuantity = json['panelQuantity'];
    if (json['panels'] != null) {
      panels = new List<Panel>();
      json['panels'].forEach((v) {
        panels.add(new Panel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['panelQuantity'] = this.panelQuantity;
    if (this.panels != null) {
      data['panels'] = this.panels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
