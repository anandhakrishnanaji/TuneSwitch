import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../providers/auth.dart';

class HistoryPage extends StatelessWidget {
  static const routeName = '/history';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final List<UserSong> _history =
        Provider.of<User>(context, listen: false).history.reversed.toList();
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 21, 89, 1),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'History',
              style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 0.048 * height,
                  fontWeight: FontWeight.w700),
            ),
            _history.length != 0
                ? Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, val) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: ListTile(
                                  title: Text(_history[val].song),
                                  subtitle: Text(_history[val].name),
                                  trailing:
                                      Text(timeago.format(_history[val].date))),
                            ),
                        itemCount: _history.length),
                  )
                : const Text('No session history!!')
          ],
        ),
      ),
    );
  }
}
