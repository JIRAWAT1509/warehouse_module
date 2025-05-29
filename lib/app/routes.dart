import 'package:flutter/material.dart';
// import 'package:warehouse_module/core/widgets/dummy_page.dart';
import 'package:warehouse_module/views/main/main_home_page.dart';
import 'package:warehouse_module/views/purchase/purchase_home_page.dart';
import 'package:warehouse_module/views/purchase/purchase_receipt_page.dart';
import 'package:warehouse_module/views/purchase/purchase_return_page.dart';
import 'package:warehouse_module/views/sales/sales_home_page.dart';
import 'package:warehouse_module/views/sales/sales_return_page.dart';
import 'package:warehouse_module/views/warehouse/warehouse_list_page.dart';
import 'package:warehouse_module/views/warehouse/warehouse_home_page.dart';

class AppRoutes {
  static const String warehouse = '/warehouse';
  static const String purchase = '/purchase';
  static const String purchaseReceipt = '/purchase/receipt';
  static const String purchaseReturn = '/purchase/return';
  static const String sales = '/sales';
  static const String warehouseList = '/sales/shipment';
  static const String salesReturn = '/sales/return';

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const MainHomePage(),
    warehouse: (context) => const WarehouseHomePage(),
    purchase: (context) => const PurchaseHomePage(),
    purchaseReceipt: (context) => const PurchaseReceiptPage(),
    purchaseReturn: (context) => const PurchaseReturnPage(),
    sales: (context) => const SalesHomePage(),
    salesReturn: (context) => const SalesReturnPage(),
    warehouseList: (context) => const WarehouseListPage(),
  };
}
