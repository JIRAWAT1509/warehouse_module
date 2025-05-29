import 'package:flutter/material.dart';
import 'package:warehouse_module/core/templates/document_detail_template.dart';

class SalesDetailPage extends StatelessWidget {
  final String docNo;

  const SalesDetailPage({super.key, required this.docNo});

  @override
  Widget build(BuildContext context) {
    return DocumentDetailTemplate(
      docNo: docNo,
      items: [
        {'itemNo': '90101 [20/20]', 'lotNo': '5678', 'qty': 2.0},
        {'itemNo': '90101 [20/20]', 'lotNo': '5679', 'qty': 3.0},
      ],
      onScan: () {
        // TODO: Implement scan logic
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Scan triggered!')));
      },
      onSubmit: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Sales Submit pressed!')));
      },
    );
  }
}
