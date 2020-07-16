import 'package:flutter/material.dart';
import './homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Attendance',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.deepPurpleAccent,
        fontFamily: 'Minecraft'
        //fontFamily: 'Nunito',
      ),
      home: HomePage(),
      routes: {},
    );
  }
}
