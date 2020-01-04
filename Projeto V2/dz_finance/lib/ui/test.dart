
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class PageAbout extends StatefulWidget {
  @override
  _PageAboutState createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  @override
  Widget build(BuildContext context) {
    // var content = StreamBuilder(
    //   stream: Firestore.instance.collection('usuarios').snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (!snapshot.hasData) return const Text('Carregando...');

    //     return ListView.builder(
    //       itemCount: snapshot.data.documents.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         DocumentSnapshot doc = snapshot.data.documents[index];

    //         return ListTile(
    //           leading: Icon(Icons.backup),
    //           title: Text(doc['nome']),
    //           trailing: GestureDetector(
    //             onTap: () {

    //             },
    //             child: Icon(Icons.delete),
    //           ),
    //         );
    //       },

    //     );
    //   }
    // );


    return Container(
      color: Colors.red,
    );
  }
}
