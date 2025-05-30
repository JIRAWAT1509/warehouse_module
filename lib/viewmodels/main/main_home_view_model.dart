import 'package:flutter/material.dart';
// import 'package:warehouse_module/app/routes.dart';

class MainHomeViewModel with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
