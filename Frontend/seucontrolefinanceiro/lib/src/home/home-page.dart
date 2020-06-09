import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seucontrolefinanceiro/src/bill-form/bill-form-page.dart';
import 'package:seucontrolefinanceiro/src/home/components/body-component.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        ""),
                  ),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            ""))),
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
                onTap: () {},
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
                onPressed: () {},
              )
            ],
          ),
        ),
        body: BodyComponent().body(context));
  }
}
