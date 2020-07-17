import 'package:flutter/material.dart';

class AlertBoxx extends StatelessWidget {
  final text, path, des;
  AlertBoxx(this.text, this.path, this.des);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 150, horizontal: 40),
      child: AlertDialog(
        backgroundColor: Colors.blueGrey[400],
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Image.asset(
                  'assets/images/cb2',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 40),
            ),
            Image.asset(
              'assets/images/$path',
              height: 140,
              width: 140,
            ),
            Text(
              des,
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
