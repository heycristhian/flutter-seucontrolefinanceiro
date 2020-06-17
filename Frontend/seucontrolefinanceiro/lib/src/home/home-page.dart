import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill-form/bill-form-page.dart';
import 'package:seucontrolefinanceiro/src/home/components/body-components.dart';
import 'package:seucontrolefinanceiro/src/login/login-page.dart';
import 'package:seucontrolefinanceiro/src/login/login-service.dart';
import 'package:seucontrolefinanceiro/src/model/user-model.dart';
import 'package:seucontrolefinanceiro/src/user/user-controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final _streamControllerUser = StreamController<UserModel>();

  final _profileImg =
      'https://pm1.narvii.com/6778/e6b5c24de706fe05cb42c6770a06f3b6becf2d93v2_hq.jpg';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    UserModel user = await UserControler.getUser();
    _streamControllerUser.add(user);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _streamControllerUser.stream,
        builder: (context, snapshot) {
          UserModel _user = snapshot.data;
          return Scaffold(
              resizeToAvoidBottomPadding: false,
              key: _scaffoldKey,
              backgroundColor: Color.fromRGBO(248, 248, 255, 1),
              drawer: Drawer(
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(_user.fullName ?? 'Null'),
                      accountEmail: Text(_user.email ?? 'Null'),
                      currentAccountPicture: GestureDetector(
                        onTap: () => debugPrint("Avatar ok!"),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(_profileImg),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors
                            .greenAccent, /*
                          image: DecorationImage(
                              fit: BoxFit.fill, image: NetworkImage(''))*/
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      title: Text("Página Inicial"),
                      trailing: Icon(
                        Icons.home,
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        print('_name');
                        print('_email');
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
                              LoginService.resetPrefs(),
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage()))
                            }),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BillFormPage()));
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
                      //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    )
                  ],
                ),
              ),
              body: BodyComponent().body(context));
        });
  }
}
