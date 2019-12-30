import 'package:dz_finance/ui/about.dart';
import 'package:dz_finance/ui/insertMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> novaLista = ["1", "2", "3"];

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
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(0),
        ));
  }

  Widget myDashboard() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        height: 200,
        child: PageView(
          controller: PageController(viewportFraction: 0.8),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              width: 100,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              width: 100,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(248, 248, 255, 1),
        //color: Colors.red,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                myAppBar(),
                myDashboard(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("Transações",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
            _historico(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _historico() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("Compras"),
            subtitle: Text("Supermercado"),
            trailing: Text(
              "R\$ -1.120,00",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
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
              SizedBox(height: 10),
              ListTile(
                title: Text("Página Inicial"),
                trailing: Icon(
                  Icons.home,
                  color: Colors.blueAccent,
                ),
              ),
              Divider(),
              ListTile(
                title: Text("Sobre"),
                trailing: Icon(
                  Icons.description,
                  color: Colors.orangeAccent,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) => PageAbout()));
                },
              ),
              Divider(),
              ListTile(
                title: Text("Sair"),
                trailing: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => InsertMoney()));
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
                onPressed: () {},
              )
            ],
          ),
        ),
        body: _body());
  }
}
