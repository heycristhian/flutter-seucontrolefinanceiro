import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/model/payment-category-model.dart';

class BillFormPage extends StatefulWidget {
  @override
  _BillFormPageState createState() => _BillFormPageState();
}

class _BillFormPageState extends State<BillFormPage> {
  DateTime _date = DateTime.now();
  final _ctrlMoney = TextEditingController();
  final _ctrlDescription = TextEditingController();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2100));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        print(_date.toString());
      });
    }
  }

  var paymentCategories = List<PaymentCategory>();
  var categoriaSelecionada = 'Salário';

  Icon icon = Icon(Icons.monetization_on, size: 50, color: Colors.white);
  Color color1 = Color.fromRGBO(17, 199, 111, 1);
  Color color2 = Colors.greenAccent;
  String _despesaOuReceita = 'Receita';

  bool _isSwitched = false;
  bool _isSwitchedAmount = false;

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
                      child: TextFormField(
                        controller: _ctrlMoney,
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
            leading: const Icon(Icons.description),
            title: TextFormField(
              controller: _ctrlDescription,
              decoration: InputDecoration(
                hintText: "Descrição...",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.calendar_today),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("$_despesaOuReceita Mensal?"),
                    subtitle: Text("Você pode modificar futuramente"),
                  ),
                ),
                Switch(
                  onChanged: (val) => setState(() => _isSwitched = val),
                  value: _isSwitched,
                ),
              ],
            ),
          ),
          _methodSameAmount(),
          SizedBox(
            height: 40,
          ),
          ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(DateFormat('dd/MM/yyy').format(_date)),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    selectDate(context);
                  })
            ],
          )),
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
                _despesaOuReceita = 'Receita';
              } else {
                color1 = Colors.red;
                color2 = Colors.redAccent;
                _despesaOuReceita = 'Despesa';
              }
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          child: InkWell(
            onTap: () {
              BillModel billModel = BillModel();
              billModel.billDescription = _ctrlDescription.text;
              billModel.payDAy = _date.toString();
              billModel.everyMonth = _isSwitched;
              billModel.amount = _ctrlMoney.text;
              billModel.sameAmount = _isSwitchedAmount;
              billModel.paid = false;
              billModel.billType =
                  (_despesaOuReceita == 'Receita') ? 'RECEIVEMENT' : 'PAYMENT';

              BillController.insertBill(billModel);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
            },
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 2, color: Colors.greenAccent)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Salvar",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.greenAccent),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _containerRendaDespesa(icon, color1, color2),
      ),
    );
  }

  _methodSameAmount() {
    if (_isSwitched) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(Icons.monetization_on),
            ),
            Expanded(
              child: ListTile(
                title: Text("Mesmo valor mensal?"),
                subtitle: Text("Você pode modificar futuramente"),
              ),
            ),
            Switch(
              onChanged: (val) => setState(() => _isSwitchedAmount = val),
              value: _isSwitchedAmount,
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
