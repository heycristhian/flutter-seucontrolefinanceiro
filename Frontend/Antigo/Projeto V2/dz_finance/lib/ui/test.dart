import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PageAbout extends StatefulWidget {
  @override
  _PageAboutState createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          // Firestore.instance
          // .collection("despesa_receita")
          // .add({
          //   "valor" : 79.90,
          //   "categoria" : "Academia",
          //   "descricao" : "Academia x-ploud",
          //   "despesa_mensal" : true,
          //   "data" : DateTime.now()
          // });

          Firestore.instance
          .collection("teste")
          .document("001")
          .setData({
            "nome" : "Matheus Assmann",
            "idade" :true
          });
        },
      ),
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
              ],
            ),
          )
        ],
      ),
    );
  }
}
