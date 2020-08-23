import 'package:flutter/material.dart';

class BottomSheetTile extends StatelessWidget {
  final text;
  BottomSheetTile(this.text);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 0.04667 * width, vertical: 0.02625 * height),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontSize: 0.041 * height),
      )),
      decoration: BoxDecoration(
          color: Colors.blueGrey, border: Border.all(color: Colors.black)),
    );
  }
}
