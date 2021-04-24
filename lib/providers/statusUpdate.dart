import 'package:flutter/material.dart';

class StatusUpdate with ChangeNotifier {
  String _chosenValue = "";
  String _status = "";
  String get status => _status;
  String get chosenValue => _chosenValue;

  void addToken(String status) {
    _status = status;
    notifyListeners();
  }

  void sort(String chosenValue) {
    _chosenValue=chosenValue;
    notifyListeners();
  }
}
