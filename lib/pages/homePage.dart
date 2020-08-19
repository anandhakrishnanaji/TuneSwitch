import 'package:flutter/material.dart';
// import 'package:spotify_sdk/spotify_sdk.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../widgets/bottomColumn.dart';
import '../widgets/playContainer.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/neonnormal.jpg'),
                fit: BoxFit.cover)),
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
                      fontSize: 40,
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
            PlayContainer(),
            // RaisedButton(
            //   child: Text('kiol'),
            //   onPressed: () async => await SpotifySdk.connectToSpotifyRemote(
            //       clientId: DotEnv().env['CLIENT_ID'],
            //       redirectUrl: DotEnv().env['REDIRECT_URL']),
            // )
          ],
        ),
      ),
    );
  }
}
