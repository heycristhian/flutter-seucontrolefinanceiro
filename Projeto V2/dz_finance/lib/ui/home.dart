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
    return Container(
      height: 180,
      color: Color.fromRGBO(17, 199, 111, 1),
    );
  }

  Widget myMainCard() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 80, 30, 30),
        child: Container(
          height: 200,
          decoration: myBoxDecoration(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white
          ),
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
          color: Color.fromRGBO(248,248,255, 1),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  myAppBar(),
                  myMainCard(),
                ],
              ),
              myCards(),
              myCards(),
              myCards(),
              myCards(),
              myCards(),
              myCards(),
              myCards(),
              myCards(),
            ],
          ),
        ));
  }
}
