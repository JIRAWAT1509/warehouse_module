import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/views/warehouse/warehouse_list_page.dart';
import 'package:warehouse_module/views/warehouse/warehouse_home_page.dart'; // Assuming this is your warehouse home page
import 'package:warehouse_module/views/user/user_profile_page.dart'; // <--- NEW: Import your UserProfilePage
import '../../viewmodels/main/main_home_view_model.dart'; // Assuming you use this viewmodel

const kMediumGrey = Color(0xFF868686);
const kDarkGreyAlmostBlack = Color(0xFF212121);

// ignore: must_be_immutable
class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0;

  // Define your pages based on the tabs
  List<Widget> pages = [
    // 0: Warehouse (home) - This is where your existing content (info, QR) would be
    const WarehouseHomePage(), // Assuming this is your primary content for the first tab
    // 1: Purchase
    Container(color: kLightGreyOffWhite, child: const Center(child: Text("Purchases Page", style: TextStyle(color: kDarkGreyAlmostBlack)))),
    // 2: Sales
    Container(color: kLightGreyOffWhite, child: const Center(child: Text("Sales Page", style: TextStyle(color: kDarkGreyAlmostBlack)))),
    // 3: User - ADDED THIS PAGE TO MATCH THE 4TH NAVIGATION DESTINATION
    const UserProfilePage(), // <--- THIS IS THE ONLY CHANGE TO THE LIST
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainHomeViewModel>(context);

    return Scaffold(
      backgroundColor: kLightGreyOffWhite, // Set the background color for the overall page
      appBar: AppBar(
        title: const Text('Warehouse App'),
        backgroundColor: kLightGreyOffWhite, // AppBar background
        foregroundColor: kDarkGreyAlmostBlack, // AppBar text/icon color
        elevation: 0, // Remove shadow
      ),
      body: pages[selectedIndex], // This will now correctly display the 4th page

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() {
          selectedIndex = value;
        }),
        backgroundColor: kPureWhite, // Background of the NavigationBar itself
        indicatorColor: kLightGreyOffWhite, // Color of the selected item's indicator
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow, // Show labels always

        destinations: [
          NavigationDestination(
            // Warehouse (home)
            icon: const Icon(Icons.inventory_2_outlined, color: kMediumGrey),
            selectedIcon: const Icon(Icons.inventory_2, color: kDarkGreyAlmostBlack),
            label: "Warehouse",
          ),
          NavigationDestination(
            // Purchase
            icon: const Icon(Icons.shopping_cart_outlined, color: kMediumGrey),
            selectedIcon: const Icon(Icons.shopping_cart, color: kDarkGreyAlmostBlack),
            label: "Purchases",
          ),
          NavigationDestination(
            // Store
            icon: const Icon(Icons.store_outlined, color: kMediumGrey),
            selectedIcon: const Icon(Icons.store, color: kDarkGreyAlmostBlack),
            label: "Store",
          ),
          NavigationDestination(
            // User
            icon: const Icon(Icons.person_outline, color: kMediumGrey),
            selectedIcon: const Icon(Icons.person, color: kDarkGreyAlmostBlack),
            label: "User",
          ),
        ],
      ),
    );
  }
}