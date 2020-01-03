import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(width: 2, color: Colors.greenAccent)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Salvar",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.greenAccent
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
