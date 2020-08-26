import 'package:flutter/material.dart';

import '../widgets/bottomColumn.dart';
import '../widgets/playContainer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlayContainer play;

  @override
  void initState() {
    play = PlayContainer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("homum");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // print(height);
    // print(width);
    return Scaffold(
      //backgroundColor: Colors.black,26, 89, 98
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Color.fromRGBO(26, 89, 98, 1)],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(0, 1),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0.02735 * height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logoassmall.png',
                      height: 0.082 * height,
                      width: 0.082 * height,
                    ),
                    Text(
                      'TuneSwitch',
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 0.0547 * height,
                      ),
                    ),
                    SizedBox(
                      width: 0.17 * width,
                    ),
                    GestureDetector(
                        child: Image.asset('assets/images/hamburger.png',
                            height: 0.0547 * height, width: 0.0547 * height),
                        onTap: () => showModalBottomSheet(
                            //isScrollControlled: true,
                            context: context,
                            builder: (context) => BottomSheetColumn()))
                  ],
                ),
              ),
              play,
              // RaisedButton(
              //   child: Text('kiol'),
              //   onPressed: () async => await SpotifySdk.connectToSpotifyRemote(
              //       clientId: DotEnv().env['CLIENT_ID'],
              //       redirectUrl: DotEnv().env['REDIRECT_URL']),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
