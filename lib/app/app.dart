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
          // Determine the initial route based on authentication state
          final initialRoute = authViewModel.isLoggedIn
              ? AppRoutes.mainHome
              : AppRoutes.login;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Warehouse App',
            theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
            initialRoute: initialRoute, // Set initial route dynamically
            routes: AppRoutes.routes,
            // Add a onGenerateRoute to handle initial routing when Navigator pops back
            // or when pushReplacementNamed is used
            onGenerateRoute: (settings) {
              if (settings.name == AppRoutes.mainHome && !authViewModel.isLoggedIn) {
                // If trying to access mainHome but not logged in, redirect to login
                return MaterialPageRoute(builder: (_) => AppRoutes.routes[AppRoutes.login]!(context));
              }
              if (settings.name == AppRoutes.login && authViewModel.isLoggedIn) {
                // If trying to access login but already logged in, redirect to mainHome
                return MaterialPageRoute(builder: (_) => AppRoutes.routes[AppRoutes.mainHome]!(context));
              }
              return MaterialPageRoute(builder: (_) => AppRoutes.routes[settings.name]!(context));
            },
          );
        },
      ),
    );
  }
}