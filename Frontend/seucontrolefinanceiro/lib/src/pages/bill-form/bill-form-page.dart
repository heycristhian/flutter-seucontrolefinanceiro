import 'dart:core';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';
import 'package:seucontrolefinanceiro/src/controllers/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/pages/home/home-page.dart';

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
  final _formKey = GlobalKey<FormState>();

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
        if (billModel != null) {
          billModel.payDAy = _date.toString().substring(0, 10);
        }
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: SingleChildScrollView(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return '';
                              return null;
                            },
                            autofocus: false,
                            controller: _ctrlMoney,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
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
                    this.currentCategory = newValue;
                    this.categoriaSelecionada = newValue;
                    if (billModel != null) {
                      billModel.paymentCategory.description = currentCategory;
                    }
                    inSetState();
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
                    child: Icon(Icons.check_circle, color: Colors.black),
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
                        _isSwitched = val;
                        inSetState();
                      });
                    },
                    value: _isSwitched,
                  ),
                ],
              ),
            ),
            _methodPortion(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(Icons.calendar_today, color: Colors.black),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectDate(context);
                        FocusScope.of(context).unfocus();
                      },
                      child: ListTile(
                        title: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(_despesaOuReceita == 'Receita'
                                    ? 'Data do recebimento'
                                    : 'Data do pagamento'),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(DateFormat('dd/MM/yyy').format(_date)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            iconDelete(),
                  SizedBox(height: 250,)

          ],
        ),
      ),
    );
  }

  DateTime backButtonPressedTime;

  @override
  Widget build(BuildContext context) {
    if (billModel != null) {
      _ctrlMoney.text = billModel.amount;
      _ctrlDescription.text = billModel.billDescription;
      _ctrlPortion.text =
          billModel.portion == null ? '' : billModel.portion.toString();
      indexPage = billModel.billType == 'RECEIVEMENT' ? 0 : 1;
      _date = DateTime.parse(billModel.payDAy);
      _attData(indexPage);
      if (billModel.portion == null) {
        billModel.portion = null;
      } else {
        _isSwitched = billModel.everyMonth;
      }
      billModel.portion = billModel.portion == null ? null : billModel.portion;

      if (!category.contains(currentCategory)) {
        currentCategory = billModel.paymentCategory.description;
      }
    }
    return _material();
  }

  _methodPortion() {
    var portion = billModel == null ? 0 : billModel.portion;
    portion = portion == null ? 0 : portion;
    if (_isSwitched && portion < 1) {
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
      padding: const EdgeInsets.only(bottom: 10),
      child: ProgressButton(
        progressWidget: const CircularProgressIndicator(),
        width: 100,
        height: 40,
        color: colorBtn,
        //Color.fromRGBO(17, 199, 111, 1),
        onPressed: () async {
          if (!_formKey.currentState.validate()) {
            return AwesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.INFO,
              body: Text(
                'O campo de valor é obrigatório. Por gentileza preencha para salvar!',
                style: TextStyle(),
              ),
              btnOkColor: Colors.blue,
              btnOkOnPress: () {},
            )..show();
          } else {
            int score = await Future.delayed(
                const Duration(milliseconds: 1000), () => 42);
            return () async {
              BillModel bill = BillModel();
              bill.billDescription = _ctrlDescription.text;
              bill.payDAy = _date.toString();
              bill.everyMonth = _isSwitched;
              bill.amount = _ctrlMoney.text.replaceAll(',', '.');
              bill.paid = false;
              bill.parentId = billModel == null ? null : billModel.parentId;
              bill.portion = (_ctrlPortion.text.isEmpty)
                  ? null
                  : int.parse(_ctrlPortion.text);
              bill.billType =
                  (_despesaOuReceita == 'Receita') ? 'RECEIVEMENT' : 'PAYMENT';
              _redirectPage(bill);
            };
          }
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
    if (billModel != null) {
      currentCategory = billModel.paymentCategory.description;
    } else {
      currentCategory = set[0];
    }
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

  inSetState() {
    if (billModel != null) {
      billModel.amount = _ctrlMoney.text;
      billModel.billDescription = _ctrlDescription.text;
      billModel.payDAy = _date.toString();
      billModel.everyMonth = _isSwitched;
      _ctrlPortion.text = '';
    }
  }

  Widget _material() {
    if (billModel == null) {
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
              if (billModel != null) {
                billModel.billType =
                    billModel.billType == 'PAYMENT' ? 'RECEIVEMENT' : 'PAYMENT';
              }
              _attData(index);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
    } else {
      Icon iconBottom = billModel.billType == 'PAYMENT'
          ? Icon(Icons.remove, size: 30, color: Colors.white)
          : Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            );
      return Material(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            backgroundColor: Colors.white,
            color: color1,
            items: <Widget>[iconBottom],
            onTap: (index) {
              _attData(index);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //iconDelete(),
                btnCancel(context),
                btnSave(context)
              ],
            ),
          ),
          body: _containerRendaDespesa(icon, color1, color2),
        ),
      );
    }
  }

  iconDelete() {
    if (billModel != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: RaisedButton(
          color: Colors.redAccent,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Apagar'),
                      content:
                          Text('Tem certeza que deseja apagar essa conta?'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              BillController.deleteBill(billModel.id);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(color: Colors.redAccent),
                            )),
                        FlatButton(
                            onPressed: () {
                              _attData(1);
                              Navigator.of(context).pop();
                              return;
                            },
                            child: Text('Não')),
                      ],
                      elevation: 24.0,
                    ),
                barrierDismissible: false);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Apagar',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 15,
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }

  void _redirectPage(BillModel bill) async {
    if (billModel == null) {
      await BillController.insertBill(bill, currentCategory);
      _delay();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else {
      bill.id = billModel.id;
      await BillController.updateBill(bill, currentCategory);
      _delay();
      Navigator.pop(context);
    }
  }

  _delay() async {
    return await Future.delayed(Duration(milliseconds: 500), () {});
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(msg: 'Clique voltar mais uma vez para sair do app',
      fontSize: 12,
      backgroundColor: Colors.black,
      textColor: Colors.white);
      return false;
    }
    return true;
  }
}
