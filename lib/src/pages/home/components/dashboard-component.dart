import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill-list/bill-list-page.dart';
import 'package:seucontrolefinanceiro/src/controllers/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/pages/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/util/privacy.dart';
import 'package:seucontrolefinanceiro/src/util/qtd-month.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class DashboardComponent extends StatefulWidget {
  Color _primaryColor = Color.fromRGBO(17, 199, 111, 1);
  DateTime _date = DateTime.now().subtract(Duration(days: 30));
  Map months = Map<int, String>();
  Map listDateTime = Map<String, String>();
  bool result = false;
  int itemCount = 0;
  final _streamController = StreamController();
  bool hidden;

  _updateDataApi(bills) async {
    List<BillModel> listBill = List<BillModel>();
    await Future.delayed(Duration(milliseconds: 500), () {});
    await BillController.getBillsByCurrentUser()
        .then((value) => value.forEach((x) {
              if (x.paid == false) {
                listBill.add(x);
                itemCount++;
              }
            }));
    bills = listBill;
  }

  Widget dashboard(BuildContext context, List<BillModel> bills, _homePageState,
      bool hidden) {
    this.hidden = hidden;
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
    months.putIfAbsent(12, () => 'Dezembro');

    _updateDataApi(bills);

    List<BillModel> billNotPaid =
        bills.where((element) => element.paid == false).toList();

    if (billNotPaid.isNotEmpty) {
      billNotPaid.sort((a, b) =>
          DateTime.parse(b.payDAy).compareTo(DateTime.parse(a.payDAy)));
      itemCount = QtdMonth.quantityMonths(billNotPaid[0].payDAy);
    } else {
      itemCount = 1;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 80, right: 0),
      child: Container(
        height: 200,
        child: PageView.builder(
          itemCount: itemCount == 0 ? 1 : itemCount,
          controller: PageController(viewportFraction: 1, initialPage: 0),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          itemBuilder: (BuildContext context, int index) {
            return _container(context, bills, index, itemCount, _homePageState);
          },
        ),
      ),
    );
  }

  Widget _container(context, List<BillModel> bills, int index, int itemCount,
      _homePageState) {
    _date = _date.add(Duration(days: 30));
    double valuePayment = 0;

    List<BillModel> newListBills = bills
        .where((element) =>
            DateTime.parse(element.payDAy).year == _date.year &&
            DateTime.parse(element.payDAy).month == _date.month &&
            element.paid == false)
        .toList();

    newListBills
        .where((element) => element.billType.compareTo('PAYMENT') == 0)
        .forEach((element) {
      valuePayment += double.parse(element.amount);
    });

    String dateString = '${_date.month} de ${_date.year}';

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
                    cardHeader(),
                    GestureDetector(
                      child: Icon(
                        Icons.remove_red_eye_sharp,
                        color: _primaryColor,
                      ),
                      onTap: () async {
                        await Privacy.changeHidden();
                        _homePageState.updateScreen();
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                Center(child: cardBody(valuePayment)),
                InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () async {
                    bool valid = await Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (BuildContext context) => BillListPage(
                                bills, dateString, index, itemCount, this.hidden)));

                    if (valid != null) {
                      if (valid) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()));
                      }
                    }
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  Widget cardHeader() {
    return Text(
      '${months[_date.month]} de ${_date.year}',
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.blueGrey),
    );
  }

  cardBody(double valuePayment) {
    if (this.hidden == null || this.hidden) {
      return Icon(Icons.clear_outlined, size: 40, color: _primaryColor);
    }

    return Text(
      'R\$ ${valuePayment.toStringAsFixed(2).replaceAll('.', ',')}',
      style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w700,
          color: (valuePayment == 0) ? Colors.green : Colors.blueAccent),
    );
  }
}
