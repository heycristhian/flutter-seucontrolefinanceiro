import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/app/controllers/bills_page_controller.dart';
import 'package:seucontrolefinanceiro/app/icons.dart';
import 'package:seucontrolefinanceiro/app/models/bill-model.dart';
import 'package:seucontrolefinanceiro/app/models/domain/panel-home.dart';
import 'package:seucontrolefinanceiro/app/pages/home/home_page.dart';
import 'package:seucontrolefinanceiro/app/pages/loader/loader_page.dart';
import 'package:seucontrolefinanceiro/app/utils.dart';

// ignore: must_be_immutable
class BillsPage extends StatefulWidget {
  int indexPage;
  BillsPage(int indexPage) {
    this.indexPage = indexPage;
  }

  @override
  _BillsPageState createState() => _BillsPageState(this.indexPage);
}

enum TripType { oneway, roundtrip, multicity }

class _BillsPageState extends State<BillsPage> {
  PanelHome panel = PanelHome();
  TripType _selectedTrip = TripType.oneway;
  var _isPayment = true;
  var currentBillsByType = List<BillModel>();
  var controller = BillsPageController();

  Map<TripType, String> _tripTypes = {
    TripType.oneway: 'PAGAMENTO',
    TripType.roundtrip: 'RECEBIMENTO',
  };

  int indexPage;

  _BillsPageState(int indexPage) {
    this.indexPage = indexPage;
  }

  @override
  void initState() {
    super.initState();
  }

  double balance = 0.0;
  double paymentAmount = 0;
  double receivementPaid = 0;
  double receivement = 0;
  double paymentAmountPaid = 0;

  DateTime backButtonPressedTime;

  @override
  Widget build(BuildContext context) {
    Future<PanelHome> panel = BillsPageController.getPanel();
    return FutureBuilder(
      future: panel,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoaderPage();
        }
        if (snapshot.hasError) {
          return LoaderPage();
        }

        setBills(snapshot.data);

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      paymentOrReceivementCard(
                                          'RECEBIMENTOS',
                                          receivement,
                                          receivementPaid,
                                          Colors.redAccent,
                                          Colors.green)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(height: 1, color: Colors.black26),
                        monthBalanceCard(),
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
                ),
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              title: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 32),
                    children: [
                      TextSpan(
                          text: getMonthTitle(),
                          style: GoogleFonts.overpass(
                              fontWeight: FontWeight.w200)),
                      TextSpan(
                          text: getYearTitle(),
                          style: GoogleFonts.overpass(
                              fontWeight: FontWeight.bold)),
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
                itemCount: getItemCountByMonths(),
                controller:
                    PageController(viewportFraction: 1, initialPage: indexPage),
                onPageChanged: (indexPage) {
                  setState(() {
                    this.indexPage = indexPage;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: getItemCount(index),
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
                                    child: billList(index),
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
      },
    );
  }

  Widget buildView() {
    return Row(
      children: <Widget>[
        paymentOrReceivementCard('PAGAMENTOS', paymentAmount, paymentAmountPaid,
            Colors.redAccent, Colors.blueAccent),
      ],
    );
  }

  Widget billList(index) {
    var bills =
        this.controller.currentBillsByType(getAllCurrentBills(), _isPayment);
    if (bills.isEmpty) {
      return Row();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              height: 60,
              width: 60,
              child: Center(
                  child: ManyIcons.iconCategory(
                      bills[index].paymentCategory.description)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bills[index].billDescription,
                  style: GoogleFonts.overpass(
                      fontSize: 24, color: Colors.deepOrange[400]),
                ),
                Text(
                  bills[index].paymentCategory.description,
                  style: GoogleFonts.overpass(
                      fontSize: 12, color: Colors.grey[900]),
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(bills[index].payDAy)),
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        getAmountText(bills[index].amount),
      ],
    );
  }

  Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;
    return FlatButton(
      padding: EdgeInsets.only(left: 4, right: 16),
      onPressed: () {
        setState(() {
          _selectedTrip = tripType;
          this._isPayment = _tripTypes[tripType] == 'PAGAMENTO';
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

  void _dialogPayBill() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Pagar'),
              content: Text(_isPayment
                  ? 'Você tem certeza que deseja pagar todas contas?'
                  : 'Vocsê tem certeza que deseja receber todas contas?'),
              actions: <Widget>[
                FlatButton(onPressed: () {}, child: Text('Sim')),
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
    var model = currentBillsByType[index];
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
                      ScreenArguments args =
                          ScreenArguments(model, this.indexPage);
                      Navigator.pushReplacementNamed(context, '/bill_form',
                          arguments: args);
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
    var model = currentBillsByType[index];
    if (!_isPayment) {
      //model = listBillReceivement[index];
      msg = 'Deseja receber somente a conta ${model.billDescription}?';
    } else {
      //model = listBillPayment[index];
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
                      await controller.payBill(currentBillsByType[index]);
                      Navigator.pop(context);
                      setState(() {});
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

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(
          msg: 'Clique em voltar mais uma vez para sair do app',
          fontSize: 12,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }

  paymentOrReceivementCard(String title, double higherValue, double lowerValue,
      higherColor, lowerColor) {
    var children2 = <Widget>[
      Text(
        title,
        style: GoogleFonts.overpass(fontSize: 16, color: Colors.grey),
      ),
      getTextBottom(higherValue, higherColor, 14),
      getTextBottom(lowerValue, lowerColor, 14),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children2,
    );
  }

  getTextBottom(double value, color, double fontSize) {
    return Text(
      'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}',
      style: GoogleFonts.overpass(fontSize: fontSize, color: color),
    );
  }

  monthBalanceCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          'SALDO DO MÊS',
          style: GoogleFonts.overpass(fontSize: 16, color: Colors.blueGrey),
        ),
        getMonthBalanceText()
      ],
    );
  }

  getMonthBalanceText() {
    String msg = 'R\$ ${balance.toStringAsFixed(2).replaceAll('.', ',')}';
    return Text(
      msg,
      style: GoogleFonts.overpass(
          fontSize: 18,
          color: balance >= 0 ? Colors.orangeAccent[400] : Colors.redAccent),
    );
  }

  getAmountText(String amount) {
    return Text(
        'R\$ ${double.parse(amount).toStringAsFixed(2).replaceAll('.', ',')}',
        style: TextStyle(color: Colors.blue[800]));
  }

  getItemCountByMonths() {
    return this.panel.panelQuantity;
  }

  getItemCount(index) {
    return this
        .controller
        .currentBillsByType(getAllCurrentBills(), _isPayment)
        .length;
  }

  getMonthTitle() {
    return this.panel.panels[indexPage].title.toLowerCase();
  }

  getYearTitle() {
    return this.panel.panels[indexPage].year.toString();
  }

  getAllCurrentBills() {
    return this.panel.panels[this.indexPage].bills;
  }

  void setBills(snapshotData) {
    this.panel = snapshotData;
    this.currentBillsByType =
        controller.currentBillsByType(getAllCurrentBills(), _isPayment);
  }
}
