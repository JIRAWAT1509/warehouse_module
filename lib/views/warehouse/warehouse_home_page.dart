import 'package:flutter/material.dart';

class WarehouseHomePage extends StatelessWidget {
  const WarehouseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warrehouse List')),
      body: const Center(child: Text('This is the wherehouse Page')),
    );
  }
}
