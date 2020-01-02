import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dz_finance/ui/componentes.dart';
import 'package:flutter/material.dart';

class InsertMoney extends StatefulWidget {
  @override
  _InsertMoneyState createState() => _InsertMoneyState();
}

class _InsertMoneyState extends State<InsertMoney> {
  static const menuCategoria = <String>[
    'Alimentação',
    'Bar/Restaurante',
    'Educação',
    'Lazer',
    'Supermercado'
  ];

  Icon icon = Icon(Icons.mood, size: 50, color: Colors.white);
  Color color1 = Color.fromRGBO(17, 199, 111, 1);
  Color color2 = Colors.greenAccent;

  Widget _containerRendaDespesa(Icon icon, Color color1, Color color2) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 8.0,
            child: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.4, 1],
                      colors: [color1, color2])),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: icon,
                      //labelText: "Teste",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: color1,
          items: <Widget>[
            Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            Icon(Icons.remove, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              if (index == 0) {
                icon = Icon(Icons.mood, size: 50, color: Colors.white);
                color1 = Color.fromRGBO(17, 199, 111, 1);
                color2 = Colors.greenAccent;
              } else {
                icon = Icon(Icons.error, size: 50, color: Colors.white);
                color1 = Colors.red;
                color2 = Colors.redAccent;
              }
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatButton(),
        body: _containerRendaDespesa(icon, color1, color2),
      ),
    );
  }
}
