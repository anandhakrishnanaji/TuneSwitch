import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import './homePage.dart';

class CarouselPage extends StatelessWidget {
  static const routeName = '/carousel';
  final List<Map> _list = [
    {
      'image': 'spot.png',
      'text': 'Make sure have installed latest version of Spotify'
    },
    {
      'image': 'normal.png',
      'text': 'In Normal mode you switch song with any user online'
    },
    {
      'image': 'travel.png',
      'text': 'In Travel mode you switch music with some random user near you'
    },
    {
      'image': 'group.png',
      'text':
          'In Channel mode you can host or join private channels with others'
    },
    {
      'image': 'love1.png',
      'text': 'Send love to other users by heart icon at the bottom'
    }
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.25 * height),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgscreen.jpg'))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/images/${_list[index]['image']}'),
                        Text(
                          _list[index]['text'],
                          style: TextStyle(
                              fontSize: 0.047 * height,
                              color: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(32, 21, 89, 1)),
                        ),
                      ],
                    ),
                  ),
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                ),
              ),
              FlatButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(HomePage.routeName),
                  child: Text(
                    'Skip >>>',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 0.041 * height,
                        backgroundColor: const Color.fromRGBO(32, 21, 89, 1)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
