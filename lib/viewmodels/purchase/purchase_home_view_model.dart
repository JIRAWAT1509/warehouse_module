import 'package:flutter/material.dart';
import '../../app/routes.dart';

class PurchaseHomeViewModel with ChangeNotifier {
  void navigateToPurchaseReceipt(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.purchaseReceipt);
  }

  void navigateToPurchaseReturn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.purchaseReturn);
  }
}
