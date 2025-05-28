import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/viewmodels/purchase/purchase_home_view_model.dart';
import 'package:warehouse_module/viewmodels/sales/sales_home_view_model.dart';
import 'package:warehouse_module/viewmodels/main/main_home_view_model.dart';
import 'package:warehouse_module/viewmodels/warehouse/warehouse_home_view_model.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainHomeViewModel()),
        ChangeNotifierProvider(create: (_) => WarehouseHomeViewModel()),
        ChangeNotifierProvider(create: (_) => PurchaseHomeViewModel()),
        ChangeNotifierProvider(create: (_) => SalesHomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Warehouse App',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
