import 'package:flutter/material.dart';

class PurchaseReceiptPage extends StatelessWidget {
  const PurchaseReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Receipt')),
      body: const Center(child: Text('This is the Purchase Receipt Page')),
    );
  }
}
