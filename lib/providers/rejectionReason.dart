import 'package:Seller_App/model/rejectionReasonsJson.dart';
import 'package:flutter/material.dart';

class RejectionReasons extends ChangeNotifier {
  String _currentReason = reasons[0];
  RejectionReasons();

  String get currentReason => _currentReason;

  updateCountry(String value) {
    if (value != _currentReason) {
      _currentReason = value;
      notifyListeners();
    }
  }
}