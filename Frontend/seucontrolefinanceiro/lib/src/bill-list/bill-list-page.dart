import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/src/bill-form/bill-form-page.dart';
import 'package:seucontrolefinanceiro/src/bill-form/util/icon-category.dart';
import 'package:seucontrolefinanceiro/src/bill/bill-controller.dart';
import 'package:seucontrolefinanceiro/src/global/qtd-month.dart';
import 'package:seucontrolefinanceiro/src/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class BillListPage extends StatefulWidget {
  List<BillModel> bills;
  String dateString;
  int index;
  int itemCount;

  BillListPage(List<BillModel> bills, String dateString, int index, itemCount) {
    this.bills = bills;
    this.dateString = dateString;
    this.index = index;
    this.itemCount = itemCount;
  }

  @override
  _BillListPageState createState() =>
      _BillListPageState(bills, dateString, index, itemCount);
}

enum TripType { oneway, roundtrip, multicity }

Map<TripType, String> _tripTypes = {
  TripType.oneway: 'PAGAMENTO',
  TripType.roundtrip: 'RECEBIMENTO',
};

class _BillListPageState extends State<BillListPage> {
  TripType _selectedTrip = TripType.oneway;
  List<BillModel> bills;
  String dateString;
  int index;
  Map months = Map<int, String>();
  int itemCount;

  _BillListPageState(
      List<BillModel> bills, String dateString, int index, int itemCount) {
    this.bills = bills;
    this.dateString = dateString;
    this.index = index;
    this.itemCount = itemCount;
  }

  @override
  void initState() {
    super.initState();
  }

  bool _isReceivement = false;
  String monthHeader;
  String yearHeader;
  DateTime _date;
  List<BillModel> listBillPayment;
  List<BillModel> listBillReceivement;
  int itemCountListBillPayment = 0;
  int itemCountListBillReceivement = 0;

  double balance = 0.0;
  double paymentAmount = 0;
  double receivementAmount = 0;
  double paymentAmountPaid = 0;

  DateTime backButtonPressedTime;

  @override
  Widget build(BuildContext context) {
    receivementAmount = receivementAmount == null ? 0 : receivementAmount;

    months.putIfAbsent(1, () => 'Janeiro');
    months.putIfAbsent(2, () => 'Fevereiro');
    months.putIfAbsent(3, () => 'Março');
    months.putIfAbsent(4, () => 'Abril');
    months.putIfAbsent(5, () => 'Maio');
    months.putIfAbsent(6, () => 'Junho');
    months.putIfAbsent(7, () => 'Julho');
    months.putIfAbsent(8, () => 'Agosto');
    months.putIfAbsent(9, () => 'Setembro');
    months.putIfAbsent(10, () => 'Outubro');
    months.putIfAbsent(11, () => 'Novembro');
    months.putIfAbsent(12, () => 'Dezembro');

    var month = dateString.split(" ")[0];
    var year = dateString.split(" ")[2];

    if (monthHeader == null) {
      monthHeader = months[int.parse(month)];
      yearHeader = year;

      listBillPayment = _returnBillsWithParams('PAYMENT', year, month, false);

      listBillReceivement =
          _returnBillsWithParams('RECEIVEMENT', year, month, false);

      _returnBillsWithParams('PAYMENT', year, month, true).forEach((x) {
        paymentAmountPaid += double.parse(x.amount);
      });

      bills
          .where((x) =>
              x.billType.compareTo('RECEIVEMENT') == 0 &&
              DateTime.parse(x.payDAy).year == int.parse(year) &&
              DateTime.parse(x.payDAy).month == int.parse(month))
          .forEach((element) {
        receivementAmount += double.parse(element.amount);
      });

      listBillPayment.forEach((element) {
        paymentAmount += double.parse(element.amount);
      });

      itemCountListBillPayment = listBillPayment.length;
      itemCountListBillReceivement = listBillReceivement.length;
      receivementAmount -= paymentAmountPaid;
      balance = receivementAmount - paymentAmount;
    }

    if (_date == null) {
      try {
        _date = DateTime.parse("$year-$month-15");
      } on Exception {
        _date = DateTime.parse("$year-0$month-15");
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Material(
            elevation: 8.0,
            child: Container(
                color: Colors.white,
                height: 150,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          onPressed: () {},
                          child: buildView(),
                        ),
                        FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'RECEBIMENTOS',
                                    style: GoogleFonts.overpass(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  Text(
                                    'R\$ ${receivementAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                                    style: GoogleFonts.overpass(
                                        fontSize: 25, color: Colors.green),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(height: 1, color: Colors.black26),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'SALDO DO MÊS',
                          style: GoogleFonts.overpass(
                              fontSize: 18, color: Colors.blueGrey),
                        ),
                        Text(
                          'R\$ ${balance.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: GoogleFonts.overpass(
                              fontSize: 25,
                              color: balance >= 0
                                  ? Colors.orangeAccent[400]
                                  : Colors.redAccent),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()));
              //Navigator.pop(context, true);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.playlist_add_check,
                color: Colors.green,
              ),
              onPressed: () {
                _dialogPayBill();
              },
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          title: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 32),
                children: [
                  TextSpan(
                      text: monthHeader,
                      style: GoogleFonts.overpass(fontWeight: FontWeight.w200)),
                  TextSpan(
                      text: yearHeader,
                      style: GoogleFonts.overpass(fontWeight: FontWeight.bold)),
                ]),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 6),
                            blurRadius: 6),
                      ]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_tripTypes.length, (index) {
                      return buildTripTypeSelector(
                          _tripTypes.keys.elementAt(index));
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
        body: WillPopScope(
                  onWillPop: onWillPop,
                  child: PageView.builder(
            itemCount: itemCount,
            controller: PageController(viewportFraction: 1, initialPage: index),
            onPageChanged: (indexPage) {
              if (indexPage > index) {
                _date = _date.add(Duration(days: 30));
              } else {
                _date = _date.subtract(Duration(days: 30));
              }
              _updateData(indexPage);
            },
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _isReceivement
                          ? itemCountListBillReceivement
                          : itemCountListBillPayment,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              height: 20,
                            ),
                            GestureDetector(
                              onDoubleTap: () {
                                _dialogPayOneBill(index);
                              },
                              child: FlatButton(
                                color: Colors.white,
                                padding: EdgeInsets.all(24),
                                onLongPress: () {
                                  _dialogUpdateBill(index);
                                },
                                onPressed: () {},
                                child: billList(
                                  _isReceivement
                                      ? listBillReceivement[index]
                                      : listBillPayment[index],
                                ),
                              ),
                            ),
                            Container(height: 1, color: Colors.black26),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildView() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'PAGAMENTOS',
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'R\$ ${paymentAmount.toStringAsFixed(2).replaceAll('.', ',')}',
              style:
                  GoogleFonts.overpass(fontSize: 25, color: Colors.blueAccent),
            )
          ],
        ),
      ],
    );
  }

  Widget billList(BillModel bill) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              height: 60,
              width: 60,
              child: Center(child: IconCategory.iconCategory(bill.paymentCategory.description)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bill.billDescription,
                  style: GoogleFonts.overpass(
                      fontSize: 24, color: Colors.deepOrange[400]),
                ),
                Text(
                  bill.paymentCategory.description,
                  style: GoogleFonts.overpass(
                      fontSize: 12, color: Colors.grey[900]),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(bill.payDAy)),
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Text('R\$ ${double.parse(bill.amount).toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
                color: _isReceivement ? Colors.green : Colors.blue[800])),
      ],
    );
  }

  Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;
    setState(() {
      _isReceivement = isSelected;
    });

    return FlatButton(
      padding: EdgeInsets.only(left: 4, right: 16),
      onPressed: () {
        setState(() {
          _selectedTrip = tripType;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: isSelected ? Colors.blue : Colors.transparent,
      child: Row(
        children: <Widget>[
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          Text(
            _tripTypes[tripType],
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _updateData(int indexPage) {
    setState(() {
      monthHeader = months[_date.month];
      yearHeader = _date.year.toString();

      index = indexPage;

      receivementAmount = 0;
      paymentAmount = 0;
      paymentAmountPaid = 0;

      listBillPayment =
          _returnBillsWithParams('PAYMENT', _date.year, _date.month, false);

      listBillReceivement =
          _returnBillsWithParams('RECEIVEMENT', _date.year, _date.month, false);

      _returnBillsWithParams('PAYMENT', _date.year, _date.month, true)
          .forEach((x) {
        paymentAmountPaid += double.parse(x.amount);
      });

      listBillPayment.forEach((element) {
        paymentAmount += double.parse(element.amount);
      });

      bills
          .where((x) =>
              x.billType.compareTo('RECEIVEMENT') == 0 &&
              DateTime.parse(x.payDAy).year == _date.year &&
              DateTime.parse(x.payDAy).month == _date.month)
          .forEach((element) {
        receivementAmount += double.parse(element.amount);
      });

      itemCountListBillPayment = listBillPayment.length;
      itemCountListBillReceivement = listBillReceivement.length;
      receivementAmount -= paymentAmountPaid;
      balance = receivementAmount - paymentAmount;
    });
  }
  
  _returnBillsWithParams(String billType, var year, var month, bool paid) {
    return bills
        .where((x) =>
            x.billType.compareTo(billType) == 0 &&
            DateTime.parse(x.payDAy).year == int.parse(year.toString()) &&
            DateTime.parse(x.payDAy).month == int.parse(month.toString()) &&
            x.paid == paid)
        .toList();
  }

  void _dialogPayBill() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Pagar'),
              content: Text(!_isReceivement ? 'Você tem certeza que deseja pagar todas contas?' : 'Vocsê tem certeza que deseja receber todas contas?'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      if (_isReceivement) {
                        listBillReceivement.forEach((x) {
                          x.paid = true;
                          BillController.updateBill(
                              x, x.paymentCategory.description);
                        });
                      } else {
                        listBillPayment.forEach((x) {
                          x.paid = true;
                          BillController.updateBill(
                              x, x.paymentCategory.description);
                        });
                      }

                      _updateData(index);
                      Navigator.of(context).pop();
                    },
                    child: Text('Sim')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Não')),
              ],
              elevation: 24.0,
            ),
        barrierDismissible: false);
  }

  void _dialogUpdateBill(int index) {
    BillModel model =
        _isReceivement ? listBillReceivement[index] : listBillPayment[index];
    var msg = 'Deseja editar a conta ${model.billDescription}';
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.orangeAccent[100],
              title: Text('Edição'),
              content: Text(msg,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) => BillFormPage(
                                  _isReceivement
                                      ? listBillReceivement[index]
                                      : listBillPayment[index])));
                      Navigator.pop(context, true);
                      _updateDataApi();
                    },
                    child: Text('Sim')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Não')),
              ],
              elevation: 24.0,
            ),
        barrierDismissible: false);
  }

  void _dialogPayOneBill(int index) {
    String msg;
    var model = BillModel();
    if (_isReceivement) {
      model = listBillReceivement[index];
      msg = 'Deseja receber somente a conta ${model.billDescription}?';
    } else {
      model = listBillPayment[index];
      msg = 'Deseja pagar somente a conta ${model.billDescription}?';
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.greenAccent[100],
              title: Text('Pagar'),
              content: Text(msg,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700)),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      model.paid = true;

                      BillController.updateBill(
                          model, model.paymentCategory.description);

                      _updateData(index);
                      Navigator.of(context).pop();
                    },
                    child: Text('Sim')),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Não')),
              ],
              elevation: 24.0,
            ),
        barrierDismissible: false);
  }

  _updateDataApi() async {
    List<BillModel> listBill = List<BillModel>();
    await Future.delayed(Duration(milliseconds: 500), () {});
    await BillController.getBillsByCurrentUser().then((value) => value.forEach((x) {listBill.add(x);}));
    bills = listBill;
    _updateData(index);
    _newIndex();
  }

  _newIndex() {
    List<BillModel> billNotPaid = bills.where((element) => element.paid == false).toList();

    if (!billNotPaid.isEmpty) {
      itemCount = QtdMonth.quantityMonths(billNotPaid[billNotPaid.length - 1].payDAy);
    } else {
      itemCount = 1;
    }
  }

   Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(msg: 'Clique em voltar mais uma vez para sair do app',
      fontSize: 12,
      backgroundColor: Colors.black,
      textColor: Colors.white);
      return false;
    }
    return true;
  }
}
