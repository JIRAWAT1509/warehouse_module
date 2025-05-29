import 'package:flutter/material.dart';
import 'package:warehouse_module/core/templates/document_list_template.dart';
import 'package:warehouse_module/views/warehouse/doc_detail_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SalesShipmentPage extends StatelessWidget {
  const SalesShipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentListTemplate(
      title: 'Sales Shipments',
      documents: [
        {'no': 'PO202505050001', 'date': '5/5/2025'},
        {'no': 'PO202515050002', 'date': '10/5/2025'},
      ],
      onScan: () {
        // TODO: Add scan logic here
        print('Scan clicked');

        Navigator.push(
          context,

          MaterialPageRoute(
            builder:
                (context) => MobileScanner(
                  onDetect: (result) {
                    print(result.barcodes.first.rawValue);
                  },
                  onDetectError: (error, stackTrace) => print("error1"),
                ),
          ),
        );
      },
      onItemTap: (item) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocDetailPage(docNo: item['no'] ?? ''),
          ),
        );
      },
    );
  }
}
