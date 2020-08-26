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
import './channelcreate.dart';
import '../pages/newbox.dart';

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

    print('rebuilding');

    return ChangeNotifierProvider(
        create: (_) => Mode(),
        child: Column(
          children: <Widget>[
            PlayerStateWidget(channel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Consumer<Mode>(
                        builder: (context, user, child) => InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => ChannelBox(channel, user,()=>posstream.cancel()),
                              ),
                              // onTap: () => Navigator.of(context).pushNamed(
                              //     NewBox.routeName,
                              //     arguments: (text) => print(text)),
                              child: Image.asset(
                                'assets/images/group.png',
                                height: 60,
                                width: 60,
                              ),
                            )),
                    Consumer<Mode>(
                      builder: (context, user, child) => user.isgroup
                          ? Image.asset(
                              'assets/images/group.png',
                              height: 60,
                              width: 60,
                            )
                          : InkWell(
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    user.normalortravel
                                        ? 'assets/images/normal.png'
                                        : 'assets/images/travel.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  Text(
                                      user.normalortravel ? 'NORMAL' : 'TRAVEL')
                                ],
                              ),
                              onTap: () {
                                print(user.normalortravel);
                                if (user.normalortravel) {
                                  posstream = geolocator
                                      .getPositionStream(locationOptions)
                                      .listen((Position position) {
                                    final room = position.latitude
                                            .toStringAsFixed(3) +
                                        position.longitude.toStringAsFixed(3);
                                    print(room);
                                    channel.sink
                                        .add(jsonEncode({'room_name': room}));
                                  });
                                } else {
                                  posstream.cancel();
                                  channel.sink
                                      .add(jsonEncode({'room_name': 'online'}));
                                }
                                user.setnot(!user.normalortravel);
                              },
                            ),
                    )
                  ]),
            ),
          ],
        ));
  }
}
