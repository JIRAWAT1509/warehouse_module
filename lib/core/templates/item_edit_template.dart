import 'package:flutter/material.dart';
import 'package:warehouse_module/core/widgets/buttons/scanner_button.dart';

class ItemEditTemplate extends StatelessWidget {
  final String docNo;
  final String category;
  final Map<String, dynamic> itemData;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const ItemEditTemplate({
    super.key,
    required this.docNo,
    required this.category,
    required this.itemData,
    this.onSave,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController lotController = TextEditingController(
      text: itemData['lotNo'] ?? '',
    );
    final TextEditingController qtyController = TextEditingController(
      text: itemData['qty']?.toString() ?? '',
    );
    final TextEditingController refQtyController = TextEditingController(
      text: itemData['refQty']?.toString() ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item ($category)'),
        actions: [
          ScannerButton(
            onPressed: () {
              // TODO: Implement scan logic if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Document No: $docNo'),
            const SizedBox(height: 12),
            Text('Item No: ${itemData['itemNo']}'),
            const SizedBox(height: 12),
            TextField(
              controller: lotController,
              decoration: const InputDecoration(labelText: 'Lot No.'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qtyController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: refQtyController,
              decoration: const InputDecoration(labelText: 'Ref Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      onSave ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Save pressed!')),
                        );
                      },
                  child: const Text('Save'),
                ),
                OutlinedButton(
                  onPressed: onCancel ?? () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
