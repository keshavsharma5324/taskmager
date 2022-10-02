import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  String _example = 'Welcome to the flutter framework';

  String get example {
    return _example;
  }

  void change(value) {
    _example = value;
    notifyListeners();
  }
}
