import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/views/warehouse/warehouse_list_page.dart';
import '../../viewmodels/main/main_home_view_model.dart';

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
  List<Widget> pages = [
    WarehouseListPage(),
    Container(child: Center(child: Text("purchase"))),
    Container(child: Center(child: Text("sales"))),
  ];
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainHomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Warehouse App')),
      body: pages[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected:
            (value) => setState(() {
              selectedIndex = value;
            }),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.inventory),
            label: "Warehouse",
          ),
          NavigationDestination(
            // Purchase
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: kMediumGrey,
            ), // Inactive icon
            selectedIcon: Icon(
              Icons.shopping_cart,
              color: kDarkGreyAlmostBlack,
            ), // Active icon
            label: "Purchases",
          ),
          NavigationDestination(
            // Store
            icon: Icon(
              Icons.store_outlined,
              color: kMediumGrey,
            ), // Inactive icon
            selectedIcon: Icon(
              Icons.store,
              color: kDarkGreyAlmostBlack,
            ), // Active icon
            label: "Store",
          ),
          NavigationDestination(
            // User
            icon: Icon(
              Icons.person_outline,
              color: kMediumGrey,
            ), // Inactive icon
            selectedIcon: Icon(
              Icons.person,
              color: kDarkGreyAlmostBlack,
            ), // Active icon
            label: "User",
          ),
        ],
      ),
    );
  }
}
