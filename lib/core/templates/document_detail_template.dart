import 'package:flutter/material.dart';
// import 'package:warehouse_module/core/widgets/buttons/scanner_button.dart';
import 'package:warehouse_module/core/widgets/item_list_widget.dart';

class DocumentDetailTemplate extends StatefulWidget {
  final String docNo;
  final List<Map<String, dynamic>> items;
  final VoidCallback? onScan;
  final VoidCallback? onSubmit;
  final VoidCallback? onDelete;
  final VoidCallback? onScanItem;
  final VoidCallback? onScanLot;

  const DocumentDetailTemplate({
    super.key,
    required this.docNo,
    required this.items,
    this.onScan,
    this.onSubmit,
    this.onDelete,
    this.onScanItem,
    this.onScanLot,
  });

  @override
  State<DocumentDetailTemplate> createState() => _DocumentDetailTemplateState();
}

class _DocumentDetailTemplateState extends State<DocumentDetailTemplate> {
  final TextEditingController qty1Controller = TextEditingController();
  final TextEditingController qty2Controller = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController binController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController lotController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('Document No: ${widget.docNo}')),
            // ScannerButton(onPressed: widget.onScan),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            //1feildperline
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: qty1Controller,
                        decoration: const InputDecoration(labelText: 'Qty 1'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: qty2Controller,
                        decoration: const InputDecoration(labelText: 'Qty 2'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: binController,
                        decoration: const InputDecoration(labelText: 'Bin No.'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: itemController,
                        decoration: const InputDecoration(
                          labelText: 'Item No.',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: lotController,
                        decoration: const InputDecoration(labelText: 'Lot No.'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ItemListWidget(
              items: widget.items,
              onItemTap: (item) {
                // TODO: Navigate to Edit Page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${item['itemNo']}')),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: widget.onSubmit ?? () {},
              child: const Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: widget.onDelete,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'itemScan',
            onPressed: widget.onScanItem,
            child: const Icon(Icons.qr_code_scanner),
            tooltip: 'Scan Item',
          ),
          // const SizedBox(height: 12),
          // FloatingActionButton(
          //   heroTag: 'lotScan',
          //   onPressed: widget.onScanLot,
          //   child: const Icon(Icons.qr_code),
          //   tooltip: 'Scan Lot',
          // ),
        ],
      ),
    );
  }
}
