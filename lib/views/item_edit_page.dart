import 'package:flutter/material.dart';

class ItemEditPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const ItemEditPage({super.key, required this.item});

  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  late TextEditingController lotController;
  late TextEditingController qty1Controller;
  late TextEditingController qty2Controller;

  @override
  void initState() {
    super.initState();
    lotController = TextEditingController(text: widget.item['lotNo'] ?? '');
    qty1Controller = TextEditingController(
      text: widget.item['qty']?.toString() ?? '1',
    );
    qty2Controller = TextEditingController(
      text: widget.item['qty']?.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    lotController.dispose();
    qty1Controller.dispose();
    qty2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Item No: ${widget.item['itemNo']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(
                text: widget.item['location'] ?? '',
              ),
              decoration: const InputDecoration(labelText: 'Location'),
              readOnly: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: widget.item['bin'] ?? ''),
              decoration: const InputDecoration(labelText: 'Bin No.'),
              readOnly: true,
            ),

            const SizedBox(height: 12),
            TextField(
              controller: lotController,
              decoration: const InputDecoration(labelText: 'Lot No.'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qty1Controller,
              decoration: const InputDecoration(labelText: 'Qty1'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qty2Controller,
              decoration: const InputDecoration(labelText: 'Qty2'),
              keyboardType: TextInputType.number,
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // onPressed: () {
                  //   Navigator.pop(context, {
                  //     'action': 'confirm',
                  //     'item': {
                  //       'itemNo': widget.item['itemNo'],
                  //       'lotNo': lotController.text,
                  //       'qty': double.tryParse(qty1Controller.text) ?? 1,
                  //       'refQty': double.tryParse(qty2Controller.text) ?? 1,
                  //       'location': widget.item['location'],
                  //       'bin': widget.item['bin'],
                  //     },
                  //   });
                  // },
                  onPressed: () {
                    final updatedItem = {
                      'itemNo': widget.item['itemNo'],
                      'lotNo': lotController.text,
                      'qty': double.tryParse(qty1Controller.text) ?? 1,
                      'location': widget.item['location'],
                      'bin': widget.item['bin'],
                    };

                    Navigator.pop(context, {
                      'action': 'confirm',
                      'item': {
                        'itemNo': widget.item['itemNo'],
                        'lotNo': lotController.text,
                        'qty': double.tryParse(qty1Controller.text) ?? 1,
                        'location': widget.item['location'],
                        'bin': widget.item['bin'],
                      },
                      'oldItem': widget.item,
                    });
                  },

                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {'action': 'cancel'});
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                              'Are you sure you want to delete this item?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                    );

                    if (confirmed == true) {
                      Navigator.pop(context, {
                        'action': 'delete',
                        'item': widget.item,
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
