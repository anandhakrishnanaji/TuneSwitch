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
import '../providers/like.dart';

class PlayContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build no\n\n\n\n\n');

    const urlpath = 'tuneswitch.herokuapp.com';

    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    final geolocator = Geolocator();

    StreamSubscription posstream;

    final WebSocketChannel channel =
        IOWebSocketChannel.connect('ws://$urlpath/ws/switch/', headers: {
      'authorization':
          'Token ${Provider.of<User>(context, listen: false).token}'
    });

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    channel.stream.listen((event) {
      print('pls\n\n\n\n');
      final spotdata = json.decode(event) as Map;
      print(spotdata.toString());
      if (spotdata['message'].containsKey('error')) {
        const snackbar = SnackBar(
          content:
              Text('There is no one present right now, Try again later ..'),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      } else if (spotdata['message'].containsKey('song')) {
        SpotifySdk.getPlayerState().then((value) {
          Provider.of<User>(context,listen: false).addsong(
              spotdata['message']['user'], DateTime.now(), spotdata['message']['song']);
          if (value.track.artist == null ||
              value.track.name == 'Spotify' ||
              value.track.name == 'Advertisement')
            SpotifySdk.queue(spotifyUri: spotdata['message']['song']);
          else
            SpotifySdk.play(spotifyUri: spotdata['message']['song']);

          Provider.of<Like>(context, listen: false)
              .setcsonguname(spotdata['message']['user']);
          Fluttertoast.showToast(
              msg:
                  'Song playing is swapped from ${spotdata['message']['user']}',
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
              gravity: ToastGravity.CENTER);
        });
      } else {
        print('sholay');
        Provider.of<Like>(context, listen: false)
            .setgotlikes(spotdata['message']['liked']);
      }
    });

    print('rebuilding');

    final _likebutton = Consumer<Like>(builder: (context, user, child) {
      print('like button loading\n\n\n\n');
      return InkWell(
        child: Image.asset(
          user.isliked ? 'assets/images/love1.png' : 'assets/images/lovew.png',
          height: 0.082 * height,
          width: 0.082 * height,
        ),
        onTap: () {
          if (!user.isliked) {
            final uname = user.csongusername;
            if (user != null) channel.sink.add(jsonEncode({'like': uname}));
            user.setliked(true);
          }
        },
      );
    });

    return ChangeNotifierProvider(
        create: (context) => Mode(),
        child: Column(
          children: <Widget>[
            PlayerStateWidget(channel),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 0.0486 * width, vertical: 0.0273 * height),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Consumer<Mode>(
                        builder: (context, user, child) => InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => ChannelBox(
                                    channel, user, () => posstream.cancel()),
                              ),
                              child: Image.asset(
                                'assets/images/group.png',
                                height: 0.082 * height,
                                width: 0.082 * height,
                              ),
                            )),
                    _likebutton,
                    Consumer<Mode>(
                      builder: (context, user, child) => user.isgroup
                          ? Image.asset(
                              'assets/images/group.png',
                              height: 0.082 * height,
                              width: 0.082 * height,
                            )
                          : InkWell(
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    user.normalortravel
                                        ? 'assets/images/normal.png'
                                        : 'assets/images/travel.png',
                                    height: 0.082 * height,
                                    width: 0.082 * height,
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
