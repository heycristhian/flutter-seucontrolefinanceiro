import 'package:dz_finance/ui/home/appbar.dart';
import 'package:dz_finance/ui/home/dashboard.dart';
import 'package:flutter/material.dart';

class MyBody {
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                MyAppBar().myAppBar(),
                MyDasshBoard().myDashboard(context)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("ÚLTIMAS TRANSAÇÕES",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            _ultimasTransacoes(),
            SizedBox(height: 10),
            _ultimasTransacoes(),
            SizedBox(height: 10),
            _ultimasTransacoes(),
            SizedBox(height: 20),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _ultimasTransacoes() {
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
