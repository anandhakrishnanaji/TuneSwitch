import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/auth.dart';
import './playerState.dart';
import '../providers/mode.dart';

class PlayContainer extends StatelessWidget {
  //bool _connected = false;

  final locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  final geolocator = Geolocator();

  @override
  Widget build(BuildContext context) {
    print('build no\n\n\n\n\n');

    final WebSocketChannel channel = IOWebSocketChannel.connect(
        'ws://192.168.1.22:8000/ws/switch/',
        headers: {
          'authorization':
              'Token ${Provider.of<User>(context, listen: false).token}'
        });

    channel.stream.listen((event) {
      print('pls\n\n\n\n');
      final spotdata = json.decode(event) as Map;
      print(spotdata['message']['song']);
      if (spotdata['message'].containsKey('error')) {
        const snackbar = SnackBar(
          content:
              Text('There is no one present right now, Try again later ..'),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      } else {
        SpotifySdk.play(spotifyUri: spotdata['message']['song']);
        Fluttertoast.showToast(
            msg: 'Song playing is swapped from ${spotdata['message']['user']}',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
            gravity: ToastGravity.CENTER);
      }
    });

    StreamSubscription posstream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      final room = position.latitude.toStringAsFixed(3) +
          position.longitude.toStringAsFixed(3);
      print(room);
      channel.sink.add({'room_name': room});
    });

    posstream.pause();

    //channel.sink.add("anandhakris");
    // return StreamBuilder(
    //     stream: SpotifySdk.subscribeConnectionStatus(),
    //     builder: (ctx, snapshot) {
    //       _connected = false;
    //       if (snapshot.data != null) {
    //         _connected = snapshot.data.connected;
    //       }
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: Text(
    //             'Connecting to spotify.....',
    //             style: TextStyle(fontSize: 30),
    //           ),
    //         );
    //       }
    //       if (_connected){
    //         print(snapshot.connectionState);
    //         print(snapshot.data);
    return ChangeNotifierProvider(
        create: (_) => Mode(),
        child: Column(
          children: <Widget>[
            PlayerStateWidget(channel),
            Consumer<Mode>(
              builder: (context, user, child) => FlatButton(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      user.normalortravel ? 'TRAVEL' : 'NORMAL',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                ),
                onPressed: () {
                  user.setnot(!user.normalortravel);
                  if (!user.normalortravel)
                    posstream.resume();
                  else
                    posstream.pause();
                },
              ),
            ),
            // StreamBuilder(
            //     stream: channel.stream,
            //     builder: (context, snapshot) {
            //       return Text(snapshot.hasData ? '${snapshot.data}' : '',
            //           style: TextStyle(fontSize: 20, color: Colors.white));
            //     }),
            // R
          ],
        ));
  }
  // else {
  //   print(snapshot.data);
  //   return Text(
  //     'Connection to Spotify failed ${snapshot.data}',
  //     style: TextStyle(fontSize: 30),
  //   );
  // }});
}
