import 'package:flutter/material.dart';
import './homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Attendance',
      theme: ThemeData(
        primarySwatch: Colors.indigo[900],
        accentColor: Colors.purpleAccent[700],
        //fontFamily: 'Nunito',
      ),
      home: HomePage(),
      routes: {},
    );
  }
}
