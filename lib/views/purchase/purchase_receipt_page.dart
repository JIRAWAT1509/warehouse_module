import 'package:flutter/material.dart';
import 'package:warehouse_module/views/warehouse/doc_detail_page.dart';
import 'package:warehouse_module/core/templates/document_list_template.dart';

class PurchaseReceiptPage extends StatelessWidget {
  const PurchaseReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentListTemplate(
      title: 'Purchase Receipt',
      documents: [
        {'no': 'PO202505050001', 'date': '5/5/2025'},
        {'no': 'PO202515050002', 'date': '10/5/2025'},
        {'no': 'PO202505050003', 'date': '10/5/2025'},
      ],
      onScan: () {
        print('Scan clicked');
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
