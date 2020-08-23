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

  @override
  void dispose() {
    usernamet.dispose();
    passwordt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgscreen.jpg'))),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 0.0584 * width),
            children: <Widget>[
              Center(
                child: Stack(children: <Widget>[
                  Hero(
                    tag: 'hero',
                    child: Image.asset(
                      'assets/images/logoas.png',
                      height: 0.3 * height,
                      width: 0.3 * height,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.246 * height),
                    child: Text('TuneSwitch',
                        style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontSize: 0.0683 * height,
                            backgroundColor:
                                const Color.fromRGBO(32, 21, 89, 1))),
                  )
                ]),
              ),
              SizedBox(height: 0.0657 * height),
              TextField(
                controller: usernamet,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.blueGrey,
                  filled: true,
                  errorText: _isntValidUsername ? "Change your username" : null,
                  labelStyle: TextStyle(fontSize: 0.3 * height),
                  hintText: !_isntValidUsername ? "Username" : null,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.0486 * width, vertical: 0.0342 * height),
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 0.0205 * height),
              TextField(
                controller: passwordt,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.blueGrey,
                  filled: true,
                  errorText: _isntValidPassword
                      ? 'Length of the password must be greater than 6'
                      : null,
                  labelStyle: TextStyle(fontSize: 0.3 * height),
                  hintText: !_isntValidPassword ? 'Enter your Password' : null,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.0486 * width, vertical: 0.0342 * height),
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 0.0329 * height),
              _isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0.0219 * height),
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
                                if (value)
                                  Navigator.of(context)
                                      .pushNamed(HomePage.routeName);
                              }).catchError((e) {
                                print(e.toString());
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertBoxx(
                                        'Login Failed!',
                                        'loginfailed.png',
                                        e.toString()));
                              });
                            }
                          },
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.121 * width,
                              vertical: 0.0137 * height),
                          color: Colors.lightBlueAccent,
                          child: Text('Log In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 0.0328 * height)),
                        ),
                        //    ),
                      ),
                      SizedBox(height: 0.0273 * height),
                      FlatButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(RegistrationScreen.routeName),
                          child: Text(
                            'Sign Up instead',
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Color.fromRGBO(32, 21, 89, 1),
                                fontSize: 0.0329 * height),
                          ))
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
