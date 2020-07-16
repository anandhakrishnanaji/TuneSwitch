import 'package:flutter/material.dart';

class BottomSheetTile extends StatelessWidget {
  final text;
  BottomSheetTile(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(19.2),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontSize: 30),
      )),
      decoration: BoxDecoration(
          color: Colors.blueGrey, border: Border.all(color: Colors.black)),
    );
  }
}
