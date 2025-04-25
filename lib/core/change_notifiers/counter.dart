import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier {
  int _counter = 0;

  int get count => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}