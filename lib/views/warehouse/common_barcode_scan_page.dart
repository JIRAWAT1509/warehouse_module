import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class CommonBarcodeScanPage extends StatefulWidget {
  // final String docNo;

  const CommonBarcodeScanPage({super.key});

  @override
  State<CommonBarcodeScanPage> createState() => _CommonBarcodeScanPageState();
}

class _CommonBarcodeScanPageState extends State<CommonBarcodeScanPage> {
  String? scanDoc;
  List<Map<String, dynamic>> items = List.empty(growable: true);

  final TextEditingController locationController = TextEditingController();
  final TextEditingController binController = TextEditingController();
  final TextEditingController lotNoController = TextEditingController();

  final MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    detectionTimeoutMs: 1000,
    formats: [
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ],
  );

  @override
  void dispose() {
    scannerController.dispose();
    locationController.dispose();
    binController.dispose();
    lotNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: scannerController,
              onDetect: (capture) {
                final code = capture.barcodes.first.rawValue;
                if (code == null) return;

                final location = locationController.text.trim();
                final bin = binController.text.trim();
                final lotNo = lotNoController.text.trim();

                final existing = items.firstWhere(
                  (item) =>
                      item['itemNo'] == code &&
                      item['location'] == location &&
                      item['bin'] == bin &&
                      item['lotNo'] == lotNo,
                  orElse: () => {},
                );

                if (existing.isNotEmpty) {
                  existing['qty'] += 1;
                } else {
                  items.add({
                    'itemNo': code,
                    'qty': 1,
                    'location': locationController.text.trim(),
                    'bin': binController.text.trim(),
                    'lotNo': lotNoController.text.trim(),
                  });
                }

                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: binController,
                  decoration: const InputDecoration(labelText: 'Bin No.'),
                ),
                TextField(
                  controller: lotNoController,
                  decoration: const InputDecoration(labelText: 'lot No.'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Item No.')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Bin')),
                DataColumn(label: Text('lotNo')),
                DataColumn(label: Text('Qty')),
              ],
              rows:
                  items
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(Text(item["itemNo"] ?? "N/A")),
                            DataCell(Text(item["location"] ?? "-")),
                            DataCell(Text(item["bin"] ?? "-")),
                            DataCell(Text(item["lotNo"] ?? "-")),
                            DataCell(Text(item["qty"].toString())),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, items);
                },
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  // final void Function(Map<String, dynamic> item)? onItemTap;

  const ItemListWidget({super.key, required this.items});

  Future<void> handleItemScan(BuildContext context, String code) async {
    final existing = items.firstWhere(
      (item) => item['itemNo'] == code,
      // item['location'] == location &&
      // item['bin'] == bin,
      // orElse: () => {},
    );

    if (existing.isNotEmpty) {
      existing['qty'] += 1;
    } else {
      items.add({
        'itemNo': code,
        // 'lotNo': '',
        'qty': 1,
        // 'location': location,
        // 'bin': bin,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: const [
              Expanded(flex: 2, child: Text('No.')),
              Expanded(flex: 3, child: Text('Item')),
              Expanded(flex: 3, child: Text('Lot no.')),
              Expanded(flex: 2, child: Text('Qty')),
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text('${index + 1}')),
                      Expanded(flex: 4, child: Text(item['itemNo'] ?? '')),
                      // Expanded(flex: 3, child: Text(item['lotNo'] ?? '')),
                      Expanded(
                        flex: 2,
                        child: Text(item['qty']?.toString() ?? ''),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, items); // ส่ง items กลับไปเลย
                },
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, null); // ยกเลิก ไม่ส่งอะไร
                },
                child: const Text('Cancel'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              ),
            ],
          ),
        ),

        // Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: ElevatedButton(
        //       onPressed: widget.onSubmit ?? () {},
        //       child: const Text('Submit'),
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: ElevatedButton(
        //       onPressed: widget.onDelete,
        //       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        //       child: const Text('Delete'),
        //     ),
        //   ),
      ],
    );
  }
}
