import 'package:flutter/material.dart';

class WarehouseHomeViewModel with ChangeNotifier {
  String _status = 'Ready';

  String get status => _status;

  void updateStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }
}
