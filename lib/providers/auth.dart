import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserSong {
  final String name;
  final DateTime date;
  final String song;
  UserSong(this.name, this.date, this.song);
}

class User with ChangeNotifier {
  String _username = null;
  String _token = null;

  static const urlpath = '192.168.1.22:8000';

  List<UserSong> _history=[];

  get history => _history;

  get token => _token;

  get username => _username;

  void addsong(String name, DateTime date, String song) {
    _history.add(UserSong(name, date, song));
  }

  Future<bool> login(String uname, String passw) async {
    const url = 'http://$urlpath/switch/login/';
    try {
      final response =
          await http.post(url, body: {'username': uname, 'password': passw});
      final jresponse = json.decode(response.body) as Map;
      if (!jresponse.containsKey('token'))
        throw ('Invalid Credentials, Check your Username and Password');
      else {
        _username = uname;
        _token = jresponse['token'];
        await _saveToken();

        return true;
      }
    } catch (e) {
      //print(e.toString());
      throw (e.toString());
    }
  }

  Future<void> _saveToken() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString('token', _token);
    shr.setString('username', _username);
  }

  Future<bool> register(String uname, String passw) async {
    const url = 'http://$urlpath/switch/userprofile/';
    try {
      final response =
          await http.post(url, body: {'username': uname, 'password': passw});
      if (response.statusCode != 201)
        throw ('Username already Exists !!!');
      else {
        final a = await login(uname, passw);
        return a;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<bool> isloggedin() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    if (shr.containsKey('token') && shr.containsKey('username')) {
      _token = shr.getString('token');
      _username = shr.getString('username');

      return true;
    } else
      return false;
  }

  Future<void> logout() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.clear();
    _token = null;
    _username = null;
  }
}
