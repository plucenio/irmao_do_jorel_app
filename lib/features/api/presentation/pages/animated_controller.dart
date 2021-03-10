import 'package:flutter/material.dart';

class AnimatedController extends ChangeNotifier {
  Duration duration = Duration(milliseconds: 1500);
  Curve curve = Curves.decelerate;

  void notify() {
    notifyListeners();
  }
}
