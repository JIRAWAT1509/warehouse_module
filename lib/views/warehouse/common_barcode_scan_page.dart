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

  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: [
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ],
  );

  //required this.docNo
  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // กล้อง สูง 300px พอ
          SizedBox(
            height: 300,
            child: MobileScanner(
              controller: controller,
              onDetect: (capture) async {
                final code = capture.barcodes.first.rawValue;
                if (code == null) return;
                print(code);

                final existing = items.firstWhere(
                  (item) => item['itemNo'] == code,
                  orElse: () => {},
                );

                if (existing.isNotEmpty) {
                  existing['qty'] += 1;
                } else {
                  items.add({'itemNo': code, 'qty': 1});
                }

                setState(() {});
              },
            ),
          ),

          // ตาราง ขยายเต็มที่
          Expanded(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Doc No.')),
                DataColumn(label: Text('Qty')),
              ],
              rows:
                  items
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(Text(item["itemNo"] ?? "N/A")),
                            DataCell(Text(item["qty"].toString())),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),

          // ปุ่ม Submit / Cancel
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, items);
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: MobileScanner(
  //             controller: controller,

  //             onDetect: (capture) async {
  //               final code = capture.barcodes.first.rawValue;
  //               if (code == null) return;
  //               print(code);

  //               if (items.isEmpty) {
  //                 items.add({'itemNo': code, 'qty': 1});
  //               } else {
  //                 final existing = items.firstWhere(
  //                   (item) => item['itemNo'] == code,
  //                   orElse: () => {},
  //                 );

  //                 if (existing.isNotEmpty) {
  //                   existing['qty'] += 1;
  //                 } else {
  //                   items.add({
  //                     'itemNo': code,
  //                     'lotNo': '',
  //                     'qty': 1,
  //                     // 'location': location,
  //                     // 'bin': bin,
  //                   });
  //                 }

  //                 // if (items.contains(code)) {
  //                 //   existing['qty'] += 1;
  //                 // } else {
  //                 //   items.add({'itemNo': code, 'qty': 1});
  //                 // }
  //               }

  //               ;

  //               setState(() {
  //                 scanDoc = code;
  //               });

  //               // Navigator.pop(context, code); // ส่งค่า code กลับ
  //             },
  //           ),
  //         ),
  //         // Expanded(child: Container(child: Text(scanDoc ?? "-"))),
  //         Expanded(
  //           child: DataTable(
  //             columns: const <DataColumn>[
  //               // DataColumn(label: Text('No.')),
  //               DataColumn(label: Text('Doc No.')),
  //               DataColumn(label: Text('qty')),
  //             ],
  //             rows:
  //                 items
  //                     .map(
  //                       (item) => DataRow(
  //                         cells: <DataCell>[
  //                           // DataCell(Text(item["qty"])),
  //                           DataCell(Text(item["itemNo"] ?? "N/A")),
  //                           DataCell(Text(item["qty"].toString())),
  //                         ],
  //                       ),
  //                     )
  //                     .toList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
              Expanded(flex: 4, child: Text('Item')),
              // Expanded(flex: 3, child: Text('Lot no.')),
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
