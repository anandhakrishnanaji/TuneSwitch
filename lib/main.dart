import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import './providers/auth.dart';
import './pages/homePage.dart';
import './pages/login_page.dart';
import './pages/registrationPage.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  await SpotifySdk.connectToSpotifyRemote(
      clientId: DotEnv().env['CLIENT_ID'],
      redirectUrl: DotEnv().env['REDIRECT_URL']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => User(),
        child: MaterialApp(
          title: 'Online Attendance',
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              accentColor: Colors.deepPurpleAccent,
              fontFamily: 'Minecraft'
              //fontFamily: 'Nunito',
              ),
          // home: FutureBuilder(
          //   future: Provider.of<User>(context).isloggedin(),
          //   builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting?HomePage():snapshot.data?HomePage():LoginScreen()
          // ),
          routes: {
            "/": (ctx) => HomePage(),
            HomePage.routeName: (ctx) => HomePage(),
            RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          },
        ));
  }
}
