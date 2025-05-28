import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/sales/sales_home_view_model.dart';

class SalesHomePage extends StatelessWidget {
  const SalesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SalesHomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                viewModel.navigateToSalesShipment(context);
              },
              child: const Text('Sales Shipment'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                viewModel.navigateToSalesReturn(context);
              },
              child: const Text('Sales Return'),
            ),
          ],
        ),
      ),
    );
  }
}
