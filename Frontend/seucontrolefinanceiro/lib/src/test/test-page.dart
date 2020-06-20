import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

nested() {
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Teste',
            ),
            background: Image.asset(
              'https://pm1.narvii.com/6778/e6b5c24de706fe05cb42c6770a06f3b6becf2d93v2_hq.jpg',
              fit: BoxFit.cover,
            ),
          ),
        )
      ];
    },
    body: Center(
      child: Text('teste 2'),
    ),
  );
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nested(),
    );
  }
}
