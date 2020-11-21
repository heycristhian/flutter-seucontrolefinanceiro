import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test appbar"),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.orange,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, top: 10, right: 40),
        child: Column(
          children: [
            retornaTextField("Nome"),
            SizedBox(
              height: 20.0,
            ),
            retornaTextField("Sobrenome"),
            SizedBox(
              height: 20.0,
            ),
            retornaTextField("Idade"),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: Container(
          height: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget retornaTextField(String descricao) {
    return TextField(decoration: InputDecoration(hintText: descricao));
  }
}
