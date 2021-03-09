import 'package:flutter/material.dart';

class AnimatedController extends ChangeNotifier {
  Duration duration = Duration(seconds: 2);
  double x = 0;
  double y = 0;
  bool _reverse = false;

  void teste() {
    if (_reverse) {
      x = 100;
      y = 100;
    } else {
      x = 0;
      y = 0;
    }
    _reverse = !_reverse;
    notifyListeners();
  }
}
