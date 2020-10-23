import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/pages/bill-form/util/icon-category.dart';
import 'package:seucontrolefinanceiro/src/controllers/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/pages/home/components/app-bar-component.dart';
import 'package:seucontrolefinanceiro/src/pages/home/components/dashboard-component.dart';
import 'package:seucontrolefinanceiro/src/pages/loader/loader.dart';

class BodyComponent {
  final _streamController = StreamController<List<BillModel>>();

  _loadBills() async {
    List<BillModel> billsByCurrentUser =
        await BillController.getBillsByCurrentUser();
    _streamController.add(billsByCurrentUser);
  }

  Widget body(BuildContext context, _homePageState) {
    _loadBills();

    return StreamBuilder(
        stream: _streamController.stream,
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
          return Container(
              color: Colors.white,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 315,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            AppBarComponent().myAppBar(),
                            DashboardComponent().dashboard(context, bills)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            height: 20,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: _timeLine(bills, _homePageState)),
                  )
                ],
              ));
        });
  }

  _timeLine(List<BillModel> bills, homePageState) {
    bills = bills.where((element) => element.paid == true).toList();
    bills.sort((a, b) => b.paidIn.toString().compareTo(a.paidIn.toString()));
    return Column(
      children: <Widget>[
        Text(
          'Movimentos',
          style: GoogleFonts.overpass(fontSize: 30, color: Colors.black87),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: bills.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                backgroundColor: Colors.red[300],
                                title: Text(
                                  'Atenção',
                                  style: TextStyle(color: Colors.black),
                                ),
                                content: Text(
                                    'Deseja desfazer o apontamento do item selecionado?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () async {
                                        bills[index].paid = false;
                                        BillController.updateBill(
                                            bills[index],
                                            bills[index]
                                                .paymentCategory
                                                .description);

                                        Navigator.pop(context);
                                        homePageState.updateScreen();
                                      },
                                      child: Text(
                                        'Sim',
                                        style: TextStyle(color: Colors.white70),
                                      )),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Não',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                                elevation: 24.0,
                              ),
                          barrierDismissible: false);
                    },
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(24),
                      onPressed: () {},
                      child: billList(bills[index]),
                    ),
                  ),
                  Container(height: 1, color: Colors.black26),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget billList(BillModel bill) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                width: 60,
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  height: 60,
                  width: 60,
                  child: Center(
                      child: IconCategory.iconCategory(
                          bill.paymentCategory.description)),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bill.billDescription,
                  style:
                      GoogleFonts.overpass(fontSize: 24, color: Colors.black87),
                ),
                Text(
                  bill.paymentCategory.description +
                      ' - ' +
                      DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(bill.paidIn)),
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('R\$ ${bill.amount}',
                style: TextStyle(color: Colors.blueAccent[700])),
            SizedBox(
              width: 10,
            ),
            bill.billType.compareTo('PAYMENT') == 0
                ? Icon(
                    Icons.arrow_upward,
                    size: 15,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.arrow_downward,
                    size: 15,
                    color: Colors.green,
                  )
          ],
        ),
      ],
    );
  }
}
