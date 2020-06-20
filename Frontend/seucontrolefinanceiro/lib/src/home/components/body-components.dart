import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/components/app-bar-component.dart';
import 'package:seucontrolefinanceiro/src/home/components/dashboard-component.dart';
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
          return Container();
        });
  }

  _timeLine() {
    /*
    return BubbleTimeline(
      bubbleDiameter: 60,
      // List of Timeline Bubble Items
      items: [
        TimelineItem(
          title: 'FEMA',
          subtitle: '05/06/2020',
          description: 'R\$ 725,00',
          child: Icon(
            Icons.library_books,
            color: Colors.white,
          ),
          bubbleColor: Colors.redAccent,
        ),
      ],
      stripColor: Colors.grey,
      scaffoldColor: Colors.white,
    );*/
  }
}
