import 'package:flutter/material.dart';
import 'package:warehouse_module/core/templates/document_list_template.dart';
import 'package:warehouse_module/views/warehouse/doc_detail_page.dart';

class PurchaseReturnPage extends StatelessWidget {
  const PurchaseReturnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentListTemplate(
      title: 'Purchase Return',
      documents: [
        {'no': 'PO202505050001', 'date': '5/5/2025'},
        {'no': 'PO202505050002', 'date': '10/5/2025'},
      ],
      onScan: () {
        // TODO: Add scan logic here
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
