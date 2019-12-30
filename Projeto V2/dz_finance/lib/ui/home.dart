import 'package:dz_finance/ui/about.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, .125)),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)));
  }

  Widget myCards() {
    return Container(
      //color: Colors.green,
      height: 200,
      margin: const EdgeInsets.fromLTRB(30, 15, 30, 15),
      decoration: myBoxDecoration(),
    );
  }

  Widget myAppBar() {
    return Material(
        elevation: 10.0,
        child: Container(
          height: 180,
          color: Color.fromRGBO(17, 199, 111, 1),
          padding: EdgeInsets.all(0),
        ));
  }

  Widget myMainCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 80, 30, 30),
      child: Container(
        height: 200,
        decoration: myBoxDecoration(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.attach_money,
                          color: Color.fromRGBO(17, 199, 111, 1),
                          size: 19.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 3.0,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(1.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Center(
                        child: Text(
                          "Saldo disponível",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(18, 18, 18, 1)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    'R\$ 2.350,87',
                    style: TextStyle(
                        color: Color.fromRGBO(17, 199, 111, 1), fontSize: 40.0),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Cristhian Dias"),
                accountEmail: Text("heycristhian@gmail.com"),
                currentAccountPicture: GestureDetector(
                  onTap: () => debugPrint("Avatar ok!"),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.licdn.com/dms/image/C4D03AQHpqao3CD5xCg/profile-displayphoto-shrink_200_200/0?e=1583366400&v=beta&t=j5T5V7HPe9VhrKw1YUDA6wyIOo3pvEJ-HUoq0zGGXaA"),
                  ),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"))),
              ),
              ListTile(
                title: Text("Página Inicial"),
                trailing: Icon(Icons.home),
              ),
              Divider(),
              ListTile(
                title: Text("Sobre"),
                trailing: Icon(Icons.description),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PageAbout()));
                },
              ),
              Divider(),
              ListTile(
                title: Text("Sair"),
                trailing: Icon(Icons.close),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {},
          backgroundColor: Color.fromRGBO(17, 199, 111, 1),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(17, 199, 111, 1),
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
        body: Container(
          color: Color.fromRGBO(248, 248, 255, 1),
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  myAppBar(),
                  myMainCard(),
                ],
              ),
            ],
          ),
        ));
  }
}
