import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../providers/auth.dart';
import './playerState.dart';

class PlayContainer extends StatelessWidget {
  // Map<String, String> spotdata = {'user': null, 'songid': null};
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://192.168.1.22:8000/ws/switch/', headers: {
    'authorization': 'Token 739b0399f5c2415847623ab1fe820d5e94b467f8'
  });
  //bool _connected = false;

  // var locationOptions =
  //     LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  // var geolocator = Geolocator();

  @override
  Widget build(BuildContext context) {
    // StreamSubscription posstream = geolocator
    //     .getPositionStream(locationOptions)
    //     .listen((Position position) {
    //   print(position);
    //   channel.sink.add({'room_name':''});
    // });
    // posstream.pause();
    channel.stream.listen((event) {
      //print('pls\n\n\n\n');
      final spotdata = json.decode(event) as Map;
      print(spotdata['message']['song']);
      SpotifySdk.play(spotifyUri: spotdata['message']['song']);
    });
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
    return Column(
      children: <Widget>[
        PlayerStateWidget(channel),
        Consumer<User>(
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
              // print("klop");
              // print(jsonEncode({'songid': 'kolash'}));
              // channel.sink.add(jsonEncode({'songid': 'spotify:track:2T7y8stcEXa9USRnzJ8C5O'}));
              // if (user.normalortravel)
              //   posstream.resume();
              // else
              //   posstream.pause();
              // user.setnot(!user.normalortravel);
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
    );
  }
  // else {
  //   print(snapshot.data);
  //   return Text(
  //     'Connection to Spotify failed ${snapshot.data}',
  //     style: TextStyle(fontSize: 30),
  //   );
  // }});
}
