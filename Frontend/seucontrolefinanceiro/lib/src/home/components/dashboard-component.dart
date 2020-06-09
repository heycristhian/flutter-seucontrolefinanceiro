import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/transactions/transaction-page.dart';

class DashboardComponent {
  Color _primaryColor = Color.fromRGBO(17, 199, 111, 1);

  Widget dashboard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        height: 200,
        child: PageView(
          controller: PageController(viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          children: <Widget>[
            _container1(context),
            _container1(context),
          ],
        ),
      ),
    );
  }

  Widget _container1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, right: 30.0, left: 30.0),
      child: Material(
        elevation: 8.0,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 9.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      color: _primaryColor,
                    ),
                    Text(
                      "Saldo disponível",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Icon(
                        Icons.attach_money,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    "R\$ 2.900,33",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: _primaryColor,
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => TransactionPage()));
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
