import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/auth.dart';
import './playerState.dart';
import '../providers/mode.dart';

class PlayContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build no\n\n\n\n\n');

    const urlpath = '192.168.1.22:8000';

    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    final geolocator = Geolocator();

    StreamSubscription posstream;

    final WebSocketChannel channel =
        IOWebSocketChannel.connect('ws://$urlpath/ws/switch/', headers: {
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
                  print(user.normalortravel);
                  if (user.normalortravel) {
                    posstream = geolocator
                        .getPositionStream(locationOptions)
                        .listen((Position position) {
                      final room = position.latitude.toStringAsFixed(3) +
                          position.longitude.toStringAsFixed(3);
                      print(room);
                      channel.sink.add(jsonEncode({'room_name': room}));
                    });
                  } else {
                    posstream.cancel();
                    channel.sink.add(jsonEncode({'room_name': 'online'}));
                  }
                  user.setnot(!user.normalortravel);
                },
              ),
            ),
          ],
        ));
  }
}
