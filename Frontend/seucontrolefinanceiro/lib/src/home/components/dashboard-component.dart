import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-service.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/transactions/transaction-page.dart';

class DashboardComponent {
  Color _primaryColor = Color.fromRGBO(17, 199, 111, 1);

  Widget dashboard(BuildContext context, valueTotal) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        height: 200,
        child: PageView(
          controller: PageController(viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          children: <Widget>[
            _container1(context, valueTotal),
          ],
        ),
      ),
    );
  }

  Widget _container1(context, valueTotal) {
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
                      "Contas a pagar (${DateTime.now().month}/${DateTime.now().year})",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w300,),
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
                    'R\$ ${valueTotal.toString()}',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: (valueTotal == 0) ? Colors.greenAccent : Colors.redAccent[200],
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
