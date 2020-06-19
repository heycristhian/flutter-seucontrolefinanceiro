import 'dart:async';

import 'package:bubble_timeline/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/components/app-bar-component.dart';
import 'package:seucontrolefinanceiro/src/home/components/dashboard-component.dart';
import 'package:seucontrolefinanceiro/src/loader/loader.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:bubble_timeline/bubble_timeline.dart';

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
              children: <Widget>[
                Loader.load()
              ],
            );
          }
          if (!snapshot.hasData) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Loader.load()
              ],
            );
          }
          List<BillModel> bills = snapshot.data;
          return _singleChildScrollView(context, bills);
        });
  }

  Widget _singleChildScrollView(context, bills) {
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
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: _timeLine(),
                  )),
            )
          ],
        ));
  }

  _timeLine() {
    return _bubble();
  }

  _bubble() {
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
        TimelineItem(
          title: 'Salário',
          subtitle: 'R\$ 5.985,00',
          description: '05/06/2020',
          child: Icon(
            Icons.monetization_on,
            color: Colors.white,
          ),
          bubbleColor: Colors.greenAccent,
        ),
        TimelineItem(
          title: 'Webby',
          subtitle: 'R\$ 99,90',
          description: '05/06/2020',
          child: Icon(
            Icons.web,
            color: Colors.white,
          ),
          bubbleColor: Colors.redAccent,
        ),
        TimelineItem(
          title: 'Vivo',
          subtitle: 'R\$ 34,99',
          description: '05/06/2020',
          child: Icon(
            Icons.phone_iphone,
            color: Colors.white,
          ),
          bubbleColor: Colors.redAccent,
        ),
        TimelineItem(
          title: 'Poupança',
          subtitle: 'R\$ 216,00',
          description: '05/06/2020',
          child: Icon(
            Icons.money_off,
            color: Colors.white,
          ),
          bubbleColor: Colors.redAccent,
        ),
        TimelineItem(
          title: 'Spotify',
          subtitle: 'R\$ 26,90',
          description: '05/06/2020',
          child: Icon(
            Icons.music_note,
            color: Colors.white,
          ),
          bubbleColor: Colors.redAccent,
        ),
      ],
      stripColor: Colors.grey,
      scaffoldColor: Colors.white,
    );
  }
}
