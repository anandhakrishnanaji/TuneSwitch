import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../providers/auth.dart';
import '../pages/newbox.dart';
// import '../providers/mode.dart';

class ChannelBox extends StatefulWidget {
  final WebSocketChannel channel;
  final value;
  final callback;
  ChannelBox(this.channel, this.value, this.callback);
  @override
  _ChannelBoxState createState() => _ChannelBoxState();
}

class _ChannelBoxState extends State<ChannelBox> {
  //bool isjoin = true;
  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    print('hi');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 0.0486 * width, vertical: 0.33 * height),
      child: AlertDialog(
        backgroundColor: Colors.blueGrey[400],
        content: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Image.asset(
                'assets/images/cb2',
                height: 0.041 * height,
                width: 0.041 * height,
              ),
            ),
          ),
          value.isgroup
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      value.groups,
                      style: TextStyle(fontSize: 30),
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/images/power.png',
                        height: 0.0684 * height,
                        width: 0.0684 * height,
                      ),
                      onTap: () {
                        widget.channel.sink
                            .add(jsonEncode({'room_name': 'online'}));
                        value.setnot(true);
                        setState(() {
                          value.setgroup(false, null);
                        });
                      },
                    ),
                  ],
                )
              : Column(children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        'Create Channel',
                        style: TextStyle(
                            color: Colors.black, fontSize: 0.0273 * height),
                      ),
                      onPressed: () {
                        if (!widget.value.normalortravel) widget.callback();
                        print(Provider.of<User>(context, listen: false).token);
                        var bytes = utf8.encode(
                            Provider.of<User>(context, listen: false).token);
                        var digest =
                            sha1.convert(bytes).toString().substring(30);
                        widget.channel.sink
                            .add(jsonEncode({'room_name': digest}));
                        setState(() {
                          value.setgroup(true, digest);
                        });
                        Fluttertoast.showToast(
                            msg:
                                'Switched to Channel Mode\nChannel ID: $digest',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
                            gravity: ToastGravity.CENTER);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Join Channel',
                          style: TextStyle(
                              color: Colors.black, fontSize: 0.0273 * height)),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(NewBox.routeName, arguments: (text) {
                        if (!widget.value.normalortravel) widget.callback();
                        widget.channel.sink.add(jsonEncode(text));
                        setState(() {
                          value.setgroup(true, text);
                        });
                        Fluttertoast.showToast(
                            msg: 'Switched to Channel Mode\nChannel ID: $text',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0.3),
                            gravity: ToastGravity.CENTER);
                      }),
                    ),
                  )
                ])
        ]),
      ),
    );
  }
}
