import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  var _username=null;
  var _token=null;

  get token {
    return _token;
  }

  get username {
    return _username;
  }

  Future<bool> login(String uname, String passw) async {
    const url = '';
    try {
      final response =
          await http.post(url, body: {'username': uname, 'password': passw});
      final jresponse = json.decode(response.body) as Map;
      if (!jresponse.containsKey('token'))
        throw ('Invalid Credentials, Check your Username and Password');
      else {
        _username=uname;
        _token = jresponse['token'];
        _saveToken();
        return true;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  void _saveToken() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString('token', _token);
    shr.setString('username', _username);
  }

  Future<bool> register(String uname,String passw)async {
    const url='';
    try{
      final response=await http.post(url,body: {'username':uname,'password':passw});
      final jresp=json.decode(response.body) as Map;
      if(!jresp.containsKey('id') || response.statusCode!=200) throw('Something wrong happened');
      else{
        final a=await login(uname, passw);
        return a;
      }
    }catch(e){
      throw(e.toString());
    }
  }

  Future<bool> isloggedin()async {
    SharedPreferences shr=await SharedPreferences.getInstance();
    if(shr.containsKey('token') && shr.containsKey('username')){
      _token=shr.getString('token');
      _username=shr.getString('username');
      return true;
    }
    else return false;
  }

  Future<void> logout() async{
    SharedPreferences shr=await SharedPreferences.getInstance();
    shr.clear();
    _token=null;
    _username=null;
  }

}
