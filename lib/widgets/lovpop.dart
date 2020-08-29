import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/like.dart';

class LovePop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final value = Provider.of<Like>(context);
    print(value.gotlikes);
    if (value.gotlikes != null) {
      Future.delayed(Duration(seconds: 5)).then((_) => value.setgotlikes(null));
      return Stack(alignment: Alignment.center, children: [
        Image.asset(
          'assets/images/lovpop.gif',
          height: 0.7292 * width,
          width: 0.7292 * width,
        ),
        Text(
          value.gotlikes,
          style: TextStyle(fontSize: 0.085*width, color: Colors.white),
        ),
      ]);
    } else
      return SizedBox();
  }
}
