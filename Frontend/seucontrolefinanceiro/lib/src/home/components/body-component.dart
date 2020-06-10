import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/components/appbar-component.dart';
import 'package:seucontrolefinanceiro/src/home/components/dashboard-component.dart';

class BodyComponent {
  Widget body(BuildContext context) {
    Future<double> valueTotal = BillController.getValueTotalMonth();

    return FutureBuilder(
        future: valueTotal,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          double value = snapshot.data;
          return _singleChildScrollView(context, value);
        });
  }

  Widget _singleChildScrollView(context, valueTotal) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                AppBarComponent().myAppBar(),
                DashboardComponent().dashboard(context, valueTotal)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("Últimos Lançamentos",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            _ultimosLancamentos(),
            SizedBox(height: 10),
            _ultimosLancamentos(),
            SizedBox(height: 10),
            _ultimosLancamentos(),
            SizedBox(height: 20),
            _ultimosLancamentos(),
          ],
        ),
      ),
    );
  }

  Widget _ultimosLancamentos() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Compras"),
              subtitle: Text("Supermercado"),
              trailing: Text(
                "R\$ -1.120,00",
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
