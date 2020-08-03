import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottomColumn.dart';
import '../widgets/playContainer.dart';
import '../providers/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName='/homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<User>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: true
                    ? AssetImage('assets/images/neonnormal.png')
                    : AssetImage('assets/images/neonpixel.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logoas.png',
                    height: 60,
                    width: 60,
                  ),
                  Text(
                    'TuneSwitch',
                    style: TextStyle(
                      color: Colors.greenAccent[400],
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  GestureDetector(
                      child: Image.asset(
                        'assets/images/hamburger.png',
                        height: 40,
                        width: 40,
                      ),
                      onTap: () => showModalBottomSheet(
                          //isScrollControlled: true,
                          context: context,
                          builder: (context) => BottomSheetColumn()))
                ],
              ),
            ),
            PlayContainer(),
            FlatButton(
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'TRAVEL MODE',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                alignment: Alignment.bottomRight,
              ),
              onPressed:null,
            )
          ],
        ),
      ),
    );
  }
}
