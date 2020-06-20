import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/components/dashboard-component.dart';
import 'package:seucontrolefinanceiro/src/loader/loader.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class AppBarComponent {
  Future<List<BillModel>> billsByCurrentUser =
      BillController.getBillsByCurrentUser();

  Widget myAppBar(context) {

    return FutureBuilder(
        future: billsByCurrentUser ?? null,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[Loader.load()],
            );
          }
          if (!snapshot.hasData) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[Loader.load()],
            );
          }

          List<BillModel> bills = snapshot.data;
          return DashboardComponent().dashboard(context, bills);
        });
  }
}
