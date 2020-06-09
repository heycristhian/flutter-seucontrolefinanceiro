
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          title: Text("Transações"),
        ),
        body: Center(
          child: Text(
            "Tela de transações",
            style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ));
  }
}
