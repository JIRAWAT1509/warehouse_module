import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:warehouse_module/core/templates/document_detail_template.dart';

class DocDetailPage extends StatelessWidget {
  final String docNo;

  const DocDetailPage({super.key, required this.docNo});

  @override
  Widget build(BuildContext context) {
    return DocumentDetailTemplate(
      docNo: docNo,
      items: [
        {'itemNo': '80101 [30/30]', 'lotNo': '1234', 'qty': 1.0},
        {'itemNo': '80101 [30/30]', 'lotNo': '1235', 'qty': 1.0},
      ],
      onScan: () {
        print('Scan clicked');

        Navigator.push(
          context,

          MaterialPageRoute(
            builder:
                (context) => MobileScanner(
                  onDetect: (result) {
                    print(result.barcodes.first.rawValue);
                    // TODO: Add scan logic here
                  },
                  onDetectError: (error, stackTrace) => print("error"),
                ),
          ),
        );
      },
      onSubmit: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Submit pressed!')));
      },
    );
  }
}
