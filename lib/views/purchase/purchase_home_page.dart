import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/purchase/purchase_home_view_model.dart';

class PurchaseHomePage extends StatelessWidget {
  const PurchaseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PurchaseHomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                viewModel.navigateToPurchaseReceipt(context);
              },
              child: const Text('Purchase Receipt'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                viewModel.navigateToPurchaseReturn(context);
              },
              child: const Text('Purchase Return'),
            ),
          ],
        ),
      ),
    );
  }
}
