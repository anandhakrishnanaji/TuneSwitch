import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './registrationPage.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';
import './homePage.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'loginscreen';
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamet = new TextEditingController();
  TextEditingController passwordt = new TextEditingController();
  bool _isntValidUsername = false,
      _isntValidPassword = false,
      _isloading = false;
  final logo = Hero(
    tag: 'hero',
    child: Image.asset(
      'assets/images/logoas.png',
      height: 220,
      width: 220,
    ),
  );

  Widget usertf() {
    return TextField(
      controller: usernamet,
      autofocus: false,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey,
        filled: true,
        errorText: _isntValidUsername ? "Change your username" : null,
        labelStyle: const TextStyle(fontSize: 20),
        hintText: !_isntValidUsername ? "Username" : null,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget passwordtf() {
    return TextField(
      controller: passwordt,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey,
        filled: true,
        errorText: _isntValidPassword
            ? 'Length of the password must be greater than 6'
            : null,
        labelStyle: const TextStyle(fontSize: 20),
        hintText: !_isntValidPassword ? 'Enter your Password' : null,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      //  child: ButtonTheme(minWidth: 20,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            (usernamet.text.isEmpty)
                ? _isntValidUsername = true
                : _isntValidUsername = false;
            (passwordt.text.length < 6)
                ? _isntValidPassword = true
                : _isntValidPassword = false;
          });
          if (!_isntValidUsername && !_isntValidPassword) {
            Provider.of<User>(context, listen: false)
                .login(usernamet.text, passwordt.text)
                .then((value) {
              if (value) Navigator.of(context).pushNamed(HomePage.routeName);
            }).catchError((e) {
              print(e.toString());
              showDialog(
                  context: context,
                  builder: (context) => AlertBoxx('Login Failed!',
                      'loginfailed.png', e.toString()));
            });
          }
        },
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        color: Colors.lightBlueAccent,
        child: const Text('Log In',
            style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      //    ),
    );
  }

  @override
  void dispose() {
    usernamet.dispose();
    passwordt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgscreen.jpg'))),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Center(
                child: Stack(children: <Widget>[
                  logo,
                  Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Text('TuneSwitch',
                        style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontSize: 50,
                            backgroundColor: Color.fromRGBO(32, 21, 89, 1))),
                  )
                ]),
              ),
              const SizedBox(height: 48.0),
              usertf(),
              const SizedBox(height: 15.0),
              passwordtf(),
              const SizedBox(height: 24.0),
              _isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(children: <Widget>[
                      loginButton(context),
                      const SizedBox(height: 20),
                      FlatButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(RegistrationScreen.routeName),
                          child: const Text(
                            'Sign Up instead',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Color.fromRGBO(32, 21, 89, 1),
                                fontSize: 24),
                          ))
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
