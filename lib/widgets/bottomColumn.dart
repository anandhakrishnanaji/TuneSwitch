import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './bottomSheetTile.dart';
import './alertBox.dart';
import '../providers/auth.dart';
import '../pages/login_page.dart';
import '../pages/historypage.dart';

class BottomSheetColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            child: BottomSheetTile('History'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(HistoryPage.routeName);
            }),
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
          child: BottomSheetTile('Report Bugs'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) => AlertBoxx('Report', 'bug.png',
                    'Noticed anything unusual?,Report bug by visiting https://github.com/anandhakrishnanaji/TuneSwitch/issues'));
          },
        ),
        GestureDetector(
          child: BottomSheetTile('About'),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) =>
                    AlertBoxx('About', 'aboutus.png', 'Github: anandhakrishnanaji\nMail: creattech2000@gmail.com'));
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
