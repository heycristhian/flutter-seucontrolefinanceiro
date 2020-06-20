import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seucontrolefinanceiro/src/bill-form/util/icon-category.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/components/app-bar-component.dart';
import 'package:seucontrolefinanceiro/src/loader/loader.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class BodyComponent {
  Widget body(BuildContext context) {
    Future<List<BillModel>> billsByCurrentUser =
        BillController.getBillsByCurrentUser();

    return FutureBuilder(
        future: billsByCurrentUser ?? null,
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppBarComponent().myAppBar(context),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          height: 20,
                        ),
                        FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.all(24),
                          onPressed: () {},
                          child: billList('desc', 'desc', 'desc'),
                        ),
                        Container(height: 1, color: Colors.black26),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        });
  }

  Widget billList(String description, String paymenteCategory, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                width: 60,
                child: Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Icon(
                      IconCategory.iconCategory(paymenteCategory),
                      size: 45,
                      color: Colors.blueGrey,
                    ))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  description,
                  style:
                      GoogleFonts.overpass(fontSize: 24, color: Colors.black87),
                ),
                Text(
                  paymenteCategory,
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Text('R\$ $amount', style: TextStyle(color: Colors.redAccent)),
      ],
    );
  }
}
