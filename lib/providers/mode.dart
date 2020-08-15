import 'package:flutter/foundation.dart';

class Mode with ChangeNotifier {


  bool _normalortravel = true;


  get normalortravel {
    return _normalortravel;
  }


  void setnot(bool not) {
    _normalortravel = not;
    notifyListeners();
  }

  
}
