import 'dart:core';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class BillFormPage extends StatefulWidget {
  BillModel billModel;
  BillFormPage(BillModel billModel) {
    this.billModel = billModel;
  }

  @override
  _BillFormPageState createState() => _BillFormPageState(billModel);
}

class _BillFormPageState extends State<BillFormPage> {
  DateTime _date = DateTime.now();
  var _ctrlMoney = TextEditingController();
  var _ctrlDescription = TextEditingController();
  var _ctrlPortion = TextEditingController();
  GlobalKey _bottomNavigationKey = GlobalKey();
  BillModel billModel;
  int indexPage = 1;

  _BillFormPageState(BillModel billModel) {
    this.billModel = billModel;
  }

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

  var categoriaSelecionada;
  var currentCategory = 'Alimentação';

  Icon icon = Icon(Icons.monetization_on, size: 50, color: Colors.white);
  Color color1 = Colors.red;
  Color color2 = Colors.redAccent;
  Color colorBtn = Colors.redAccent;
  bool verify;

  String _despesaOuReceita = 'Despesa';

  bool _isSwitched = false;
  bool _isSwitchedAmount = false;

  List<String> category = [
    'Alimentação',
    'Banco',
    'Compras',
    'Dívidas',
    'Educação',
    'Impostos',
    'Lanchonetes',
    'Lazer',
    'Presentes',
    'Roupas',
    'Serviços',
    'Supermercado',
    'Transporte',
    'Viagem',
    'Outros'
  ];

  Widget _containerRendaDespesa(Icon icon, Color color1, Color color2) {
    return SingleChildScrollView(
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
                        autofocus: false,
                        controller: _ctrlMoney,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
          ListTile(
            leading: const Icon(Icons.devices_other),
            title: DropdownButton<String>(
              value: currentCategory,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              isExpanded: true,
              items: category.map((String dropdownStringItem) {
                return DropdownMenuItem(
                  value: dropdownStringItem,
                  child: Text(dropdownStringItem),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  this.categoriaSelecionada = newValue;
                  this.currentCategory = newValue;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.calendar_today, color: Colors.black),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("$_despesaOuReceita Mensal?"),
                    subtitle: Text("Você pode modificar futuramente"),
                  ),
                ),
                Switch(
                  //onChanged: (val) => setState(() => _isSwitched = val),
                  onChanged: (bool val) {
                    setState(() {
                      print('val: ' + val.toString());
                      _isSwitched = val;
                    });
                  },
                  value: _isSwitched,
                ),
              ],
            ),
          ),
          _methodSameAmount(),
          _methodPortion(),
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
    if (billModel != null) {
      _ctrlMoney.text = billModel.amount;
      _ctrlDescription.text = billModel.billDescription;
      _ctrlPortion.text = billModel.portion.toString();
      indexPage = billModel.billType == 'RECEIVEMENT' ? 0 : 1;
      _attData(indexPage);
      if (billModel.portion == null) {
        billModel.portion = 0;
      } else {
        _isSwitched = true;
      }
      billModel.portion = billModel.portion == null ? 0 : billModel.portion;
    }
    return Material(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: indexPage,
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
            if(billModel != null) {
              billModel.billType =
                billModel.billType == 'PAYMENT' ? 'RECEIVEMENT' : 'PAYMENT';
            }
            
            _attData(index);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[btnCancel(context), btnSave(context)],
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

  _methodPortion() {
    if (_isSwitchedAmount) {
      return ListTile(
        leading: const Icon(
          Icons.format_list_numbered,
          color: Colors.black,
        ),
        title: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          controller: _ctrlPortion,
          decoration: InputDecoration(
            hintText: "Quantidade de parcelas...",
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  btnSave(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: ProgressButton(
        progressWidget: const CircularProgressIndicator(),
        width: 100,
        height: 40,
        color: colorBtn,
        //Color.fromRGBO(17, 199, 111, 1),
        onPressed: () async {
          int score = await Future.delayed(
              const Duration(milliseconds: 1000), () => 42);
          // After [onPressed], it will trigger animation running backwards, from end to beginning
          return () {
            // Optional returns is returning a VoidCallback that will be called
            // after the animation is stopped at the beginning.
            // A best practice would be to do time-consuming task in [onPressed],
            // and do page navigation in the returned VoidCallback.
            // So that user won't missed out the reverse animation.
            BillModel billModel = BillModel();
            billModel.billDescription = _ctrlDescription.text;
            billModel.payDAy = _date.toString();
            billModel.everyMonth = _isSwitched;
            billModel.amount = _ctrlMoney.text;
            billModel.sameAmount = _isSwitchedAmount;
            billModel.paid = false;
            billModel.portion = (_ctrlPortion.text.isEmpty)
                ? null
                : int.parse(_ctrlPortion.text);
            billModel.billType =
                (_despesaOuReceita == 'Receita') ? 'RECEIVEMENT' : 'PAYMENT';

            BillController.insertBill(billModel, currentCategory);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
          };
        },
        defaultWidget: Text(
          'SALVAR',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }

  btnCancel(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ProgressButton(
        progressWidget: const CircularProgressIndicator(),
        width: 100,
        height: 40,
        color: Colors.blueGrey,
        onPressed: () async {
          if (billModel == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
          } else {
            Navigator.pop(context);
          }
        },
        defaultWidget: Text(
          'Cancelar',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
    );
  }

  List<String> _returnSetPaymentOrReceivement(bool isPayment) {
    category.removeWhere((element) => element != 'removing');
    List<String> set = List<String>();

    if (isPayment) {
      set.add('Alimentação');
      set.add('Banco');
      set.add('Compras');
      set.add('Dívidas');
      set.add('Educação');
      set.add('Impostos');
      set.add('Lanchonetes');
      set.add('Lazer');
      set.add('Presentes');
      set.add('Roupas');
      set.add('Saúde');
      set.add('Serviços');
      set.add('Supermercado');
      set.add('Transporte');
      set.add('Viagem');
      set.add('Outros');
    } else {
      set.add('Empréstimo');
      set.add('Investimento');
      set.add('Salário');
      set.add('Outros');
    }
    currentCategory = set[0];
    return set;
  }

  _attData(int index) {
    setState(() {
      icon = Icon(Icons.monetization_on, size: 50, color: Colors.white);
      if (index == 0) {
        colorBtn = Color.fromRGBO(17, 199, 111, 1);
        color1 = Color.fromRGBO(17, 199, 111, 1);
        color2 = Colors.greenAccent;
        _despesaOuReceita = 'Receita';
        category = _returnSetPaymentOrReceivement(false);
      } else {
        color1 = Colors.red;
        color2 = Colors.redAccent;
        colorBtn = Colors.redAccent;
        _despesaOuReceita = 'Despesa';
        category = _returnSetPaymentOrReceivement(true);
      }
    });
  }
}
