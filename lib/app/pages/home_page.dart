import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/app/components/text_components.dart';
import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/pages/loader/loader_page.dart';
import 'package:seucontrolefinanceiro/app/providers/panel_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future<PanelHome> panelHome = PanelProvider.getPanels();
    _streamController.add(panelHome);
  }

  final _streamController = StreamController();
  PanelHome panelHome;
  Color _primaryColor = Color.fromRGBO(17, 199, 111, 1);
  Color _transparentColor = Color(0x00000000);

  @override
  Widget build(BuildContext context) {
    Future<PanelHome> panelHomeFuture = PanelProvider.getPanels();
    return FutureBuilder(
        future: panelHomeFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoaderPage();
          }
          if (snapshot.hasError) {
            return LoaderPage();
          }
          this.panelHome = snapshot.data;

          return Scaffold(
            body: Container(
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  getCards(),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }

  Widget getCards() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 180,
              color: _primaryColor,
              child: Material(
                elevation: 50,
                child: Container(
                  color: _primaryColor,
                ),
              ),
            ),
            Container(
              height: 170,
              color: _transparentColor,
            ),
          ],
        ),
        Container(
            color: _transparentColor,
            margin: EdgeInsets.only(top: 90),
            height: 200,
            child: PageView.builder(
              itemCount: getItemCount(),
              controller: PageController(viewportFraction: 1, initialPage: 0),
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 15, left: 15, bottom: 20),
                  height: 200,
                  color: Colors.white,
                  child: Material(
                      elevation: 8.0,
                      child: Column(
                        children: [
                          Material(
                            elevation: 5.0,
                            child: Container(
                                margin: EdgeInsets.only(top: 5),
                                width: double.infinity,
                                height: 35,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextComponents.textWithGoogleFont(
                                        text: getCurrentMonthYear(index),
                                        color: Colors.blueGrey,
                                        fontSize: 15.0)
                                  ],
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: TextComponents.textWithGoogleFont(
                                  text: 'R\$ ' + getCurrentAmount(index),
                                  color: _primaryColor,
                                  fontSize: 40.0))
                        ],
                      )),
                );
              },
            ))
      ],
    );
  }

  getItemCount() {
    return this.panelHome.panelQuantity;
  }

  String getCurrentAmount(index) {
    return this.panelHome.panels[index].amount.toStringAsFixed(2);
  }

  String getCurrentMonthYear(index) {
    return '${this.panelHome.panels[index].title} de ${this.panelHome.panels[index].year.toString()}';
  }
}
