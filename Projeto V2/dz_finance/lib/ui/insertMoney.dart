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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.done, color: Colors.white, ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.4, 1],
                  colors: [Theme.of(context).primaryColor, Colors.blue])),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 50.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                    size: 50.0,
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
