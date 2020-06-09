import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/home/components/appbar-component.dart';
import 'package:seucontrolefinanceiro/src/home/components/dashboard-component.dart';

class BodyComponent {
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                AppBarComponent().myAppBar(),
                DashboardComponent().dashboard(context)
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
            SizedBox(height: 20),
            _ultimosLancamentos(),
            SizedBox(height: 20),
            _ultimosLancamentos(),
            SizedBox(height: 20),
            _ultimosLancamentos(),
            SizedBox(height: 20),
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
