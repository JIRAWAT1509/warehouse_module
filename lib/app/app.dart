import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/viewmodels/main/main_home_view_model.dart';
import 'package:warehouse_module/viewmodels/warehouse/warehouse_home_view_model.dart';
import 'package:warehouse_module/viewmodels/warehouse/warehouse_list_view_model.dart';
import 'package:warehouse_module/viewmodels/auth/auth_view_model.dart'; // Ensure this is imported
import 'package:warehouse_module/app/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => MainHomeViewModel()),
        ChangeNotifierProvider(create: (_) => WarehouseHomeViewModel()),
        ChangeNotifierProvider(create: (_) => WarehouseListViewModel()),
      ],
      // <--- IMPORTANT CHANGE HERE ---
      // Wrap MaterialApp with a Consumer to react to AuthViewModel changes
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Warehouse App',
            theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
            initialRoute: authViewModel.isLoggedIn ? AppRoutes.mainHome : AppRoutes.login,
            routes: AppRoutes.routes,
            onGenerateRoute: (settings) {
              // Redirect to login if trying to access mainHome while not logged in
              if (settings.name == AppRoutes.mainHome && !authViewModel.isLoggedIn) {
                return MaterialPageRoute(builder: (_) => AppRoutes.routes[AppRoutes.login]!(context));
              }
              // Redirect to mainHome if trying to access login while already logged in
              if (settings.name == AppRoutes.login && authViewModel.isLoggedIn) {
                return MaterialPageRoute(builder: (_) => AppRoutes.routes[AppRoutes.mainHome]!(context));
              }
              // Default route handling
              return MaterialPageRoute(builder: (_) => AppRoutes.routes[settings.name]!(context));
            },
          );
        },
      ),
    );
  }
}
