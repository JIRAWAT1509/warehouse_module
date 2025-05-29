import 'package:flutter/material.dart';

class ScannerButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ScannerButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.qr_code_scanner),
      onPressed:
          onPressed ??
          () {
            // Default behavior (optional)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Scanner action not implemented')),
            );
          },
    );
  }
}
