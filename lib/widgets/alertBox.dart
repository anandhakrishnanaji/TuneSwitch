import 'package:flutter/material.dart';

class AlertBoxx extends StatelessWidget {
  final text, path, des;
  AlertBoxx(this.text, this.path, this.des);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 0.2 * height, horizontal: 0.097 * width),
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
                  height: 0.041 * height,
                  width: 0.041 * height,
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 0.05 * height),
            ),
            Image.asset(
              'assets/images/$path',
              height: 0.191 * height,
              width: 0.191 * height,
            ),
            Text(
              des,
              style: TextStyle(
                fontSize: 0.027 * height,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
