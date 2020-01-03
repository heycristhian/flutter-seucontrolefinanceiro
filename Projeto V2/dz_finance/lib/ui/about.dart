import 'package:flutter/material.dart';

class PageAbout extends StatefulWidget {
  @override
  _PageAboutState createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste"),
      ),
      body: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String newValue) {
            setState(() {
      dropdownValue = newValue;
            });
          },
          isExpanded: true,
          items: <String>['One', 'Two', 'Free', 'Four']
      .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
            );
          }).toList(),
        ),
    );
  }
}
