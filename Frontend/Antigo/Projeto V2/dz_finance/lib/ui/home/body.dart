import 'package:dz_finance/ui/home/appbar.dart';
import 'package:dz_finance/ui/home/dashboard.dart';
import 'package:dz_finance/ui/transacoes/transacoes.dart';
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
            _aPagar(context),
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

  Widget _aPagar(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 160,
              child: Material(
                elevation: 8.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 9.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Contas a pagar",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "R\$ 1.110,89",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.redAccent,
                          onTap: () {},
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),

          // SEGUNDO CONTAINER

          SizedBox(
            width: 20,
          ),

          Expanded(
            child: Container(
              height: 160,
              child: Material(
                elevation: 8.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 9.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Contas a receber",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Stack(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "R\$ 2.900,33",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.greenAccent,
                          onTap: () {},
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
