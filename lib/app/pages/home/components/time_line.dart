import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seucontrolefinanceiro/app/icons.dart';
import 'package:seucontrolefinanceiro/app/models/bill-model.dart';
import 'package:seucontrolefinanceiro/app/providers/bill_provider.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  List<BillModel> billsPaid = List<BillModel>();
  @override
  Widget build(BuildContext context) {
    Future<List<BillModel>> billsFuture = BillProvider.getBillsPaid();
    return FutureBuilder(
      future: billsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return getCircularProgress();
        }
        if (snapshot.hasError) {
          return getCircularProgress();
        }
        billsPaid = snapshot.data;
        return timeLineBody();
      },
    );
  }

  getCircularProgress() {
    return Container(
        child: Expanded(
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              ),
            ),
          )
        ],
      ),
    ));
  }

  timeLineBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: getItemCount(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 20,
              ),
              GestureDetector(
                onLongPress: () {
                  getDialog();
                },
                child: FlatButton(
                  color: Colors.white,
                  padding: EdgeInsets.all(24),
                  onPressed: () {},
                  child: billList(billsPaid[index]),
                ),
              ),
              Container(height: 1, color: Colors.black26),
            ],
          );
        },
      ),
    );
  }

  getDialog() {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.red[300],
              title: Text(
                'Atenção',
                style: TextStyle(color: Colors.black),
              ),
              content: Text(
                  'Deseja desfazer o apontamento do item selecionado?',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {},
                    child: Text(
                      'Sim',
                      style: TextStyle(color: Colors.white70),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Não', style: TextStyle(color: Colors.white))),
              ],
              elevation: 24.0,
            ),
        barrierDismissible: false);
  }

  getItemCount() {
    return this.billsPaid.length;
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
                  padding: EdgeInsets.only(right: 10),
                  height: 60,
                  width: 60,
                  child: Center(
                      child: ManyIcons.iconCategory(
                          'bill.paymentCategory.description')),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  bill.billDescription,
                  style:
                      GoogleFonts.overpass(fontSize: 24, color: Colors.black87),
                ),
                Text(
                  bill.paymentCategory.description +
                      ' - ' +
                      DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(bill.payDAy)),
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('R\$ 0', style: TextStyle(color: Colors.blueAccent[700])),
            SizedBox(
              width: 10,
            ), /*
            bill.billType.compareTo('PAYMENT') == 0
                ? Icon(
                    Icons.arrow_upward,
                    size: 15,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.arrow_downward,
                    size: 15,
                    color: Colors.green,
                  )*/
          ],
        ),
      ],
    );
  }
}
