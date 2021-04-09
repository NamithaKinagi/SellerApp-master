import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenModel with ChangeNotifier {
  

  String _token = "";
  DateTime _signInOn;
  String get token => _token;
  DateTime get signInOn => _signInOn;

  void addToken(String token) {
    _token = token;
    _signInOn = DateTime.now();
    notifyListeners();
  }
}

