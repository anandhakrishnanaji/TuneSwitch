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
          vertical: 0.205 * height, horizontal: 0.09722 * width),
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
                  height: 0.41 * height,
                  width: 0.41 * height,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 40),
            ),
            Image.asset(
              'assets/images/$path',
              height: 0.191 * height,
              width: 0.191 * height,
            ),
            Text(
              des,
              style: const TextStyle(
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
