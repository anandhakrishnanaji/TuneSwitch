import 'package:flutter/material.dart';

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

  Widget passwordtf(String text, String errortext) {
    bool _foo = text == "Password" ? _isntValidPassword : _isntValidPassword2;
    return TextField(
      controller: text == "Password" ? passwordt : password2t,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey,
        filled: true,
        errorText: _foo ? errortext : null,
        labelStyle: const TextStyle(fontSize: 20),
        hintText: !_foo ? text : null,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget usertf() {
    return TextField(
      controller: usernamet,
      autofocus: false,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey,
        filled: true,
        errorText: _isntValidUsername ? "Username already exists" : null,
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

  Widget registerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
          if (!_isntValidPassword && !_isntValidPassword2) {}
        },
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        color: Colors.lightBlueAccent,
        child: const Text('Register',style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      //    ),
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
    return Scaffold(
      //backgroundColor:Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bgscreen.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(5, 19, 48, 1)),
              ),
              const SizedBox(height: 48.0),
              usertf(),
              const SizedBox(height: 15.0),
              passwordtf(
                  "Password", "Length of password must be greater than 6"),
              const SizedBox(height: 15.0),
              passwordtf("Confirm Password", "Passowrds do not match"),
              const SizedBox(height: 24.0),
              _isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(children: <Widget>[
                      registerButton(context),
                      const SizedBox(height: 20),
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Login instead',
                              style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Color.fromRGBO(5, 19, 48, 1),
                                  fontSize: 24)))
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
