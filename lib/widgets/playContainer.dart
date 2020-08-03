import 'dart:ffi';

import 'package:flutter/material.dart';

class PlayContainer extends StatefulWidget {
  @override
  _PlayContainerState createState() => _PlayContainerState();
}

class _PlayContainerState extends State<PlayContainer> {
  bool play=true;
  bool normal=true;



  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        Text(
          'Track Name',
          style:
              TextStyle(fontFamily: '8bit', color: Colors.white, fontSize: 40),
        ),
        Text(
          'Artist,ALbum',
          style:
              TextStyle(fontFamily: '8bit', color: Colors.white, fontSize: 20),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 6),
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/index.jpeg',
                  ),
                  fit: BoxFit.cover)),
          width: 300,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'assets/images/previous.png',
                height: 50,
                width: 50,
              ),
              Image.asset('assets/images/play.png', height: 50, width: 50),
              Image.asset('assets/images/next.png', height: 50, width: 50)
            ],
          ),
        )
      ],
    );
  }
}
