import 'package:flutter/foundation.dart';

class Mode with ChangeNotifier {
  bool _normalortravel = true;
  bool _isgroup = false;
  String _groups;

  get normalortravel {
    return _normalortravel;
  }

  void setnot(bool not) {
    _normalortravel = not;
    notifyListeners();
  }

  get isgroup => _isgroup;

  get groups=>_groups;

  void setgroup(bool gp, String g) {
    _groups = g;
    _isgroup = gp;
    notifyListeners();
  }
}
