import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_format/date_format.dart';
import 'package:dz_finance/ui/componentes.dart';
import 'package:flutter/material.dart';

class InsertMoney extends StatefulWidget {
  @override
  _InsertMoneyState createState() => _InsertMoneyState();
}

class _InsertMoneyState extends State<InsertMoney> {
  var menuCategoria = [
    'Alimentação',
    'Bar/Restaurante',
    'Educação',
    'Lazer',
    'Supermercado'
  ];

  var categoriaSelecionada = 'Alimentação';

  Icon icon = Icon(Icons.monetization_on, size: 50, color: Colors.white);
  Color color1 = Color.fromRGBO(17, 199, 111, 1);
  Color color2 = Colors.greenAccent;

  String retornaData() {
    var date = formatDate(
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            [dd, '/', mm, '/', yyyy]) +
        ' - ' +
        DateTime.now().hour.toString() +
        ':' +
        DateTime.now().minute.toString();
    return date;
  }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
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
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, right: 30),
                    child: Divider(
                      color: Colors.white,
                      height: 10,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: DropdownButton<String>(
              value: categoriaSelecionada,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              isExpanded: true,
              items: menuCategoria.map((String dropdownStringItem) {
                return DropdownMenuItem(
                  value: dropdownStringItem,
                  child: Text(dropdownStringItem),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  this.categoriaSelecionada = newValue;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.description),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Descrição...",
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Data'),
            subtitle: Text(retornaData()),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
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
              icon = Icon(Icons.monetization_on, size: 50, color: Colors.white);
              if (index == 0) {
                color1 = Color.fromRGBO(17, 199, 111, 1);
                color2 = Colors.greenAccent;
              } else {
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
