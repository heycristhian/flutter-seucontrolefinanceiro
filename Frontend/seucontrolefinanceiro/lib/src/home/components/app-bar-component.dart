import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/home/components/dashboard-component.dart';

class AppBarComponent {
  Widget myAppBar(context, bills) {
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
                      Material(
                          elevation: 10.0,
                          child: Container(
                            height: 180,
                            color: Color.fromRGBO(17, 199, 111, 1),
                            padding: EdgeInsets.all(0),
                          )),
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
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: _timeLine(),
                  )),
            )
          ],
        ));
  }
}
