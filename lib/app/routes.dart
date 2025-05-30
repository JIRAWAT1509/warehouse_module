import 'package:flutter/material.dart';
import 'package:warehouse_module/views/main/main_home_page.dart';
import 'package:warehouse_module/views/warehouse/warehouse_list_page.dart';

// Import your new auth pages
import 'package:warehouse_module/views/auth/login_page.dart';
import 'package:warehouse_module/views/auth/signup_page.dart';
import 'package:warehouse_module/views/user/user_profile_page.dart';
import 'package:provider/provider.dart';

// <--- ADD THIS IMPORT for AuthViewModel
import 'package:warehouse_module/viewmodels/auth/auth_view_model.dart';


class AppRoutes {
  // Define new route constants
  static const String login = '/login';
  static const String signup = '/signup';
  static const String mainHome = '/';
  static const String warehouse = '/warehouse';
  static const String purchase = '/purchase';
  static const String purchaseReceipt = '/purchase/receipt';
  static const String purchaseReturn = '/purchase/return';
  static const String sales = '/sales';
  static const String warehouseList = '/sales/shipment';
  static const String salesReturn = '/sales/return';
  static const String userProfile = '/user-profile'; // <--- Route for UserProfilePage


  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    signup: (context) => const SignUpPage(),
    mainHome: (context) => const MainHomePage(),
    warehouseList: (context) => const WarehouseListPage(),
    // For userProfile route, you need to provide the username
    userProfile: (context) {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      return UserProfilePage(username: authViewModel.currentUsername ?? 'Guest');
    },
    purchase: (context) => Container(color: Colors.white, child: const Center(child: Text("Purchases Page"))),
    // You also need to define the 'sales' route if you have it in your constants
    // sales: (context) => Container(color: Colors.white, child: const Center(child: Text("Sales Page"))),
  };
}