import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/main/main_home_view_model.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainHomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Warehouse App')),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.inventory),
                  onPressed: () {
                    viewModel.navigateToWarehouse(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    viewModel.navigateToPurchase(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.sell),
                  onPressed: () {
                    viewModel.navigateToSales(context);
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Select a section from the navbar above'),
            ),
          ),
        ],
      ),
    );
  }
}
