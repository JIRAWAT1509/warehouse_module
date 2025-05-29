import 'package:flutter/material.dart';
import '../../app/routes.dart';

class SalesHomeViewModel with ChangeNotifier {
  void navigateToSalesShipment(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.warehouseList);
  }

  void navigateToSalesReturn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.salesReturn);
  }
}
