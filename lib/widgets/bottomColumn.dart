import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './bottomSheetTile.dart';
import './alertBox.dart';
import '../providers/auth.dart';
import '../pages/login_page.dart';

class BottomSheetColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(child: BottomSheetTile('History'), onTap: null),
        GestureDetector(child: BottomSheetTile('Stats'), onTap: null),
        GestureDetector(
          child: BottomSheetTile('Donate'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) => AlertBoxx('Donate', 'dialogheart.png',
                    'If you enjoy the app,\nBuy a Coffee to the developers'));
          },
        ),
        GestureDetector(
          child: BottomSheetTile('Contribute'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) => AlertBoxx('Contribute', 'github.gif',
                    'Liike to add Features?,\nContribute by visiting https://github.com/anandhakrishnanaji/TuneSwitch'));
          },
        ),
        GestureDetector(
          child: BottomSheetTile('About'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) =>
                    AlertBoxx('About', 'aboutus.png', 'anandhakris'));
          },
        ),
        GestureDetector(
          child: BottomSheetTile('Logout'),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<User>(context, listen: false).logout().then((value) =>
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false));
          },
        ),
      ],
    );
  }
}
