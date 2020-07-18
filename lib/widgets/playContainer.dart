import 'package:flutter/material.dart';

class PlayContainer extends StatefulWidget {
  @override
  _PlayContainerState createState() => _PlayContainerState();
}

class _PlayContainerState extends State<PlayContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Now Playing',
          style: TextStyle(
              backgroundColor: Color.fromRGBO(5, 19, 48, 1),
              fontFamily: '8bit',
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w700),
        ),
        Text(
          'Track Name',
          style: TextStyle(
              backgroundColor: Color.fromRGBO(5, 19, 48, 1),
              fontFamily: '8bit',
              color: Colors.white,
              fontSize: 40),
        ),
        Text(
          'Artist,ALbum',
          style: TextStyle(
              fontFamily: '8bit',
              color: Colors.white,
              backgroundColor: Color.fromRGBO(5, 19, 48, 1),
              fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'assets/images/previous.jpg',
                height: 50,
                width: 50,
              ),
              Image.asset('assets/images/play.jpg', height: 50, width: 50),
              Image.asset('assets/images/next.jpg', height: 50, width: 50)
            ],
          ),
        )
      ],
    );
  }
}
