
import 'package:flutter/material.dart';

class Transacoes extends StatefulWidget {
  @override
  _TransacoesState createState() => _TransacoesState();
}

class _TransacoesState extends State<Transacoes> {
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
