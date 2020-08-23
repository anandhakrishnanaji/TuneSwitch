import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './homePage.dart';
import '../providers/auth.dart';
import '../widgets/alertBox.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = '/regpage';
  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController passwordt = new TextEditingController();
  TextEditingController usernamet = new TextEditingController();
  TextEditingController password2t = new TextEditingController();
  bool _isntValidPassword = false,
      _isntValidPassword2 = false,
      _isntValidUsername = false,
      _isloading = false;

  Widget passwordtf(
      String text, String errortext, double height, double width) {
    bool _foo = text == "Password" ? _isntValidPassword : _isntValidPassword2;
    return TextField(
      controller: text == "Password" ? passwordt : password2t,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey,
        filled: true,
        errorText: _foo ? errortext : null,
        labelStyle: TextStyle(fontSize: 0.3 * height),
        hintText: !_foo ? text : null,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 0.0486 * width, vertical: 0.0342 * height),
        border: OutlineInputBorder(),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernamet.dispose();
    password2t.dispose();
    passwordt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor:Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/bgscreen.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 0.0584 * width),
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 0.054 * height,
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(32, 21, 89, 1)),
              ),
              SizedBox(height: 0.0657 * height),
              TextField(
                controller: usernamet,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.blueGrey,
                  filled: true,
                  errorText:
                      _isntValidUsername ? "Username already exists" : null,
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
              passwordtf("Password",
                  "Length of password must be greater than 6", height, width),
              SizedBox(height: 0.0205 * height),
              passwordtf(
                  "Confirm Password", "Passowrds do not match", height, width),
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
                              (passwordt.text.length < 6)
                                  ? _isntValidPassword = true
                                  : _isntValidPassword = false;
                              (password2t.text != passwordt.text)
                                  ? _isntValidPassword2 = true
                                  : _isntValidPassword2 = false;
                            });
                            if (!_isntValidPassword && !_isntValidPassword2) {
                              Provider.of<User>(context, listen: false)
                                  .register(usernamet.text, passwordt.text)
                                  .then((value) {
                                if (value)
                                  Navigator.of(context)
                                      .pushNamed(HomePage.routeName);
                              }).catchError((e) => showDialog(
                                      context: context,
                                      builder: (context) => AlertBoxx(
                                          'Registration Failed !!',
                                          'loginfailed.png',
                                          e.toString())));
                            }
                          },
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.121 * width,
                              vertical: 0.0137 * height),
                          color: Colors.lightBlueAccent,
                          child: Text('Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 0.0328 * height)),
                        ),
                        //    ),
                      ),
                      SizedBox(height: 0.0273 * height),
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Login instead',
                              style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor:
                                      Color.fromRGBO(32, 21, 89, 1),
                                  fontSize: 0.0329 * height)))
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
