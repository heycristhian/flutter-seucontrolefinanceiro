import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class DashboardComponent {
  Color _primaryColor = Color.fromRGBO(17, 199, 111, 1);

  Widget dashboard(BuildContext context, bills) {
    Map map = Map<int, int>();
    Map months = Map<int, String>();
    months.putIfAbsent(1, () => 'Janeiro');
    months.putIfAbsent(2, () => 'Fevereiro');
    months.putIfAbsent(3, () => 'Março');
    months.putIfAbsent(4, () => 'Abril');
    months.putIfAbsent(5, () => 'Maio');
    months.putIfAbsent(6, () => 'Junho');
    months.putIfAbsent(7, () => 'Julho');
    months.putIfAbsent(8, () => 'Agosto');
    months.putIfAbsent(9, () => 'Setembro');
    months.putIfAbsent(10, () => 'Outubro');
    months.putIfAbsent(11, () => 'Novembro');
    months.putIfAbsent(2, () => 'Dezembro');
    

    for (BillModel b in bills) {
      int month = DateTime.parse(b.payDAy).month;
      int year = DateTime.parse(b.payDAy).year;
      map.putIfAbsent(month, () => year);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        height: 200,
        child: PageView(
          controller: PageController(viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          children: <Widget>[
            _container(context, bills, '${months[6]}'),/*
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),
            _container(context, bills),*/
          ],
        ),
      ),
    );
  }

  Widget _container(context, List<BillModel> bills, String title) {
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
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
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
                    'R\$ ${1900}',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color:
                          (0 == 0) ? Colors.greenAccent : Colors.redAccent[200],
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    print(title);
                    /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TransactionPage()));*/
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
