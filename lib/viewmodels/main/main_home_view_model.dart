import 'package:flutter/material.dart';
// import 'package:warehouse_module/app/routes.dart';

class MainHomeViewModel with ChangeNotifier {
  void navigateToWarehouse(BuildContext context) {
    Navigator.pushNamed(context, '/warehouse');
  }

  void navigateToPurchase(BuildContext context) {
    Navigator.pushNamed(context, '/purchase');
  }

  void navigateToSales(BuildContext context) {
    Navigator.pushNamed(context, '/sales');
  }
}
