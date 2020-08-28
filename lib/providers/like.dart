import 'package:flutter/foundation.dart';

class Like with ChangeNotifier {
  bool _isliked = false;
  String _gotlikes=null;
  String _csongusername = null;

  get csongusername => _csongusername;
  get isliked => _isliked;
  get gotlikes => _gotlikes;

  void setcsonguname(String newu) {
    _csongusername = newu;
  }

  void setliked(bool val) {
    _isliked = val;
    notifyListeners();
  }

  void setgotlikes(String val) {
    _gotlikes = val;
    notifyListeners();
  }

}
