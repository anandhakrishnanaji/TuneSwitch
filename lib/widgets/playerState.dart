import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';

import './albumWidget.dart';
import '../providers/mode.dart';

class PlayerStateWidget extends StatelessWidget {
  final path = 'assets/images/';
  final WebSocketChannel channel;
  bool initialsend = false;
  PlayerStateWidget(this.channel);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print('kj');
    return StreamBuilder<PlayerState>(
        initialData: PlayerState(null, true, 1, 1, null, null),
        stream: SpotifySdk.subscribePlayerState(),
        builder: (ctx, snapshot) {
          print(snapshot.data);
          print('hello');
          if (snapshot.data != null && snapshot.data.track != null) {
            PlayerState playerstate = snapshot.data;
            if (!initialsend && playerstate.track.uri != null) {
              print('initial\n\n\n\n');
              channel.sink.add(jsonEncode({'songid': playerstate.track.uri}));
              initialsend = true;
            }
            final p = snapshot.data.isPaused ? 'play.png' : 'pause.png';
            print(playerstate.track.name);
            return Column(
              children: <Widget>[
                const FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Now Playing',
                    style: TextStyle(
                        fontFamily: '8bit',
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '${playerstate.track.name}',
                    style: const TextStyle(
                        fontFamily: '8bit', color: Colors.white, fontSize: 40),
                    // softWrap: true,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '${playerstate.track.artist.name},${playerstate.track.album.name}',
                    style: const TextStyle(
                        fontFamily: '8bit', color: Colors.white, fontSize: 20),
                  ),
                ),
                AlbumWidget(playerstate.track.imageUri),
                Padding(
                  padding: EdgeInsets.all(0.0273 * height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        child: Image.asset(
                          'assets/images/previous.png',
                          height: 0.122 * width,
                          width: 0.122 * width,
                        ),
                        onTap: () async {
                          SpotifySdk.skipPrevious();
                        },
                      ),
                      InkWell(
                        child: Image.asset('assets/images/$p',
                            height: 0.122 * width, width: 0.122 * width),
                        onTap: () async {
                          if (snapshot.data.isPaused)
                            await SpotifySdk.resume();
                          else
                            await SpotifySdk.pause();
                        },
                      ),
                      Consumer<Mode>(
                        builder: (context, user, child) => InkWell(
                          onTap: () {
                            if (user.normalortravel &&
                                playerstate.track.uri != null)
                              channel.sink.add(jsonEncode(
                                  {'songid': playerstate.track.uri}));
                          },
                          child: Image.asset('assets/images/next.png',
                              height: 0.122 * width, width: 0.122 * width),
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
                style: TextStyle(fontSize: 0.041 * height),
              ),
            );
        });
  }
}
