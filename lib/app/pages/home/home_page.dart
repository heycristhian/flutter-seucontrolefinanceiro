import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seucontrolefinanceiro/app/components/text_components.dart';
import 'package:seucontrolefinanceiro/app/controllers/home_controller.dart';
import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/models/user-model.dart';
import 'package:seucontrolefinanceiro/app/pages/home/components/time_line.dart';
import 'package:seucontrolefinanceiro/app/pages/loader/loader_page.dart';
import 'package:seucontrolefinanceiro/app/providers/panel_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  UserModel userModel = UserModel();
  @override
  void initState() {
    super.initState();
    Future<PanelHome> panelHome = PanelProvider.getPanels();
    _streamController.add(panelHome);
    HomeController.getUser().then((value) => {userModel = value});
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
            key: _scaffoldKey,
            drawer: getDrawer(),
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 320,
                    color: Colors.white,
                    child: getCards(),
                  ),
                  Divider(),
                  Center(
                    child: Text(
                      'Movimentos',
                      style: GoogleFonts.overpass(
                          fontSize: 30, color: Colors.black87),
                    ),
                  ),
                  TimeLine()
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                //EFEITO
              },
              backgroundColor: Theme.of(context).primaryColor,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).primaryColor,
              shape: CircularNotchedRectangle(),
              notchMargin: 4.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  getDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              userModel.fullName ?? 'Fullname',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(userModel.email ?? 'E-mail',
                style: TextStyle(color: Colors.white)),
            currentAccountPicture: GestureDetector(
              onTap: () => debugPrint("Avatar ok!"),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/user.png'),
                  radius: 35,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("assets/bg.jpg"))),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("Página Inicial"),
            trailing: Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Gráficos"),
            trailing: Icon(
              Icons.equalizer,
              color: Colors.orangeAccent,
            ),
            onTap: () {
              Navigator.pop(context);
              /*Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => Graphs()));*/
            },
          ),
          Divider(),
          ListTile(
              title: Text("Sair"),
              trailing: Icon(
                Icons.close,
                color: Colors.redAccent,
              ),
              onTap: () => {
                    HomeController.logout(context)
                    /*LoginService.resetPrefs(),*/
                    /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage(true)))
                            */
                  }),
        ],
      ),
    );
  }

  Widget getCards() {
    return Column(
      children: [
        Stack(
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
                  height: 130,
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
                  controller:
                      PageController(viewportFraction: 1, initialPage: 0),
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
                )),
          ],
        ),
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
