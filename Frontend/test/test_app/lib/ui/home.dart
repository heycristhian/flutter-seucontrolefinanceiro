
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to learn this hell"),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu), onPressed: () => debugPrint("Olá"),),
          
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
      onPressed: () => debugPrint("teste"),
      tooltip: 'Increment Counter',
      child: const Icon(Icons.airplanemode_active),),

      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("heycristhian",
            style: TextStyle(
              fontSize: 80.5,
              fontWeight: FontWeight.w700,
              color: Colors.deepOrange
            ),
            ),
            Padding(padding: EdgeInsets.all(15.0),
            child: InkWell(
              child: Text("Clique",
                style: TextStyle(fontSize: 16.0),
              ),
              onLongPress: () => debugPrint("Tap"),
            ),
          )
          ],
        ),
      ),

      
    );
  }
}