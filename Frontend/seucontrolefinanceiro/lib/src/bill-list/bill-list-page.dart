import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/src/bill-form/util/icon-category.dart';
import 'package:seucontrolefinanceiro/src/model/bill-model.dart';

class BillListPage extends StatefulWidget {
  List<BillModel> bills;
  String dateString;

  BillListPage(List<BillModel> bills, String dateString) {
    this.bills = bills;
    this.dateString = dateString;
  }

  @override
  _BillListPageState createState() => _BillListPageState(bills, dateString);
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

  _BillListPageState(List<BillModel> bills, String dateString) {
    this.bills = bills;
    this.dateString = dateString;
  }

  double paymentAmount = 0;
  double receivementAmount = 0;
  bool _isReceivement = false;

  @override
  Widget build(BuildContext context) {
    paymentAmount = 0;
    receivementAmount = 0;

    setState(() {
      receivementAmount = receivementAmount == null ? 0 : receivementAmount;
    });

    var month = dateString.split(" ")[0];
    var year = dateString.split(" ")[2];

    List<BillModel> listBillPayment =
        bills.where((x) => x.billType.compareTo('PAYMENT') == 0).toList();

    List<BillModel> listBillReceivement =
        bills.where((x) => x.billType.compareTo('RECEIVEMENT') == 0).toList();

    listBillPayment.forEach((element) {
      paymentAmount += double.parse(element.amount);
    });

    listBillReceivement.forEach((element) {
      receivementAmount += double.parse(element.amount);
    });

    int itemCountListBillPayment = listBillPayment.length;
    int itemCountListBillReceivement = listBillReceivement.length;
    double balance = receivementAmount - paymentAmount;

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
                          onPressed: () {
                            print('_isReceivement => ' +
                                _isReceivement.toString());
                          },
                          child: buildTravellersView(),
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
                                    'R\$ $receivementAmount',
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
                          'R\$ $balance',
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
          elevation: 0,
          backgroundColor: Colors.white,
          title: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 32),
                children: [
                  TextSpan(
                      text: month,
                      style: GoogleFonts.overpass(fontWeight: FontWeight.w200)),
                  TextSpan(
                      text: year,
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
        body: ListView.builder(
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
                FlatButton(
                  color: Colors.white,
                  padding: EdgeInsets.all(24),
                  onPressed: () {},
                  child: billList(
                    _isReceivement
                        ? listBillReceivement[index]
                        : listBillPayment[index],
                  ),
                ),
                Container(height: 1, color: Colors.black26),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTravellersView() {
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
              'R\$ $paymentAmount',
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
                width: 60,
                child: Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Icon(
                      IconCategory.iconCategory(bill.paymentCategory.description),
                      size: 45,
                      color: Colors.blueGrey,
                    ))),
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
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.grey[900]),
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(bill.payDAy)),
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Text('R\$ ${bill.amount}',
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
}
