import 'package:dz_finance/ui/home/body.dart';
import 'package:dz_finance/ui/test.dart';
import 'package:dz_finance/ui/insertMoney/insertMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(248, 248, 255, 1),
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
        body: MyBody().body(context));
  }
}
