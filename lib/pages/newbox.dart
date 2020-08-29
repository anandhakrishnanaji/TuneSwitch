import 'package:flutter/material.dart';

class NewBox extends StatefulWidget {
  static const routeName = '/newbox';
  @override
  _NewBoxState createState() => _NewBoxState();
}

class _NewBoxState extends State<NewBox> {
  TextEditingController newgroup;
  bool _isntvalidgroup = false;
  @override
  void initState() {
    newgroup = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newgroup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callback = ModalRoute.of(context).settings.arguments as Function;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      body: Padding(
        padding: EdgeInsets.all(0.0486 * width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: newgroup,
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                errorText:
                    _isntvalidgroup ? "Entered Channel ID is Invalid" : null,
                labelStyle: TextStyle(fontSize: 0.3 * height),
                hintText: "Channel ID",
                contentPadding:const  EdgeInsets.all(5),
                border: OutlineInputBorder(),
                prefixIcon: const Icon(
                  Icons.group,
                  color: Colors.black,
                ),
              ),
            ),
            RaisedButton(
                onPressed: () {
                  setState(() {
                    (newgroup.text.isEmpty || newgroup.text.length < 10)
                        ? _isntvalidgroup = true
                        : _isntvalidgroup = false;
                  });
                  if (!_isntvalidgroup) {
                    callback(newgroup.text);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Join'))
          ],
        ),
      ),
    );
  }
}
