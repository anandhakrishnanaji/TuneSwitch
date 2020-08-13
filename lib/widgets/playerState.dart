import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';

import './albumWidget.dart';
import '../providers/auth.dart';

class PlayerStateWidget extends StatelessWidget {
  final path = 'assets/images/';
  final WebSocketChannel channel;
  bool initialsend = false;
  PlayerStateWidget(this.channel);

  @override
  Widget build(BuildContext context) {
    print('kj');
    return StreamBuilder<PlayerState>(
        initialData: PlayerState(null, true, 1, 1, null, null),
        stream: SpotifySdk.subscribePlayerState(),
        builder: (ctx, snapshot) {
          print(snapshot.data);
          print('hello');
          if (snapshot.data != null && snapshot.data.track != null) {
            PlayerState playerstate = snapshot.data;
            if (!initialsend) {
              print('initial\n\n\n');
              channel.sink.add(jsonEncode({'songid': playerstate.track.uri}));
              initialsend = true;
            }
            final p = snapshot.data.isPaused ? 'play.png' : 'pause.png';
            return Column(
              children: <Widget>[
                Text(
                  'Now Playing',
                  style: TextStyle(
                      fontFamily: '8bit',
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '${playerstate.track.name}',
                    style: TextStyle(
                        fontFamily: '8bit', color: Colors.white, fontSize: 40),
                    softWrap: true,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '${playerstate.track.artist.name},${playerstate.track.album.name}',
                    style: TextStyle(
                        fontFamily: '8bit', color: Colors.white, fontSize: 20),
                  ),
                ),
                AlbumWidget(playerstate.track.imageUri),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Image.asset(
                          'assets/images/previous.png',
                          height: 50,
                          width: 50,
                        ),
                        onTap: () async {
                          SpotifySdk.skipPrevious();
                        },
                      ),
                      InkWell(
                        child: Image.asset('assets/images/$p',
                            height: 50, width: 50),
                        onTap: () async {
                          if (snapshot.data.isPaused)
                            await SpotifySdk.resume();
                          else
                            await SpotifySdk.pause();
                        },
                      ),
                      Consumer<User>(
                        builder: (context, user, child) => InkWell(
                          onTap: () {
                            if (user.normalortravel)
                              channel.sink.add(jsonEncode(
                                  {'songid': playerstate.track.uri}));
                          },
                          child: Image.asset('assets/images/next.png',
                              height: 50, width: 50),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else
            return Center(
              child: Text(
                'Not Connected',
                style: TextStyle(fontSize: 30),
              ),
            );
        });
  }
}
