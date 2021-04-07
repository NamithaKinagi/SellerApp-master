import 'package:flutter/material.dart';

class StatusUpdate with ChangeNotifier {
   String _status = "";
  String get status => _status;

  void addToken(String status) {
    _status = status;
    notifyListeners();
  }
}