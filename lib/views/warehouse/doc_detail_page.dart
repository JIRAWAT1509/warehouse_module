import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/viewmodels/warehouse/doc_detail_view_model.dart';
import 'package:warehouse_module/core/templates/document_detail_template.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:warehouse_module/views/warehouse/common_barcode_scan_page.dart';

class DocDetailPage extends StatelessWidget {
  final String docNo;

  const DocDetailPage({super.key, required this.docNo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocDetailViewModel(docNo),
      child: Consumer<DocDetailViewModel>(
        builder: (context, viewModel, _) {
          return DocumentDetailTemplate(
            docNo: docNo,
            viewModel: viewModel,
            onScanItem: () async {
              final scannedItems = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CommonBarcodeScanPage()),
              );

              if (scannedItems != null &&
                  scannedItems is List<Map<String, dynamic>>) {
                viewModel.handleScannedItems(scannedItems);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Items added!')));
              }
            },

            onScanLot: () async {
              final code = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => MobileScanner(
                        onDetect: (capture) async {
                          final code = capture.barcodes.first.rawValue;
                          if (code == null) return;
                          Navigator.pop(context, code);
                        },
                      ),
                ),
              );

              if (code != null) {
                viewModel.handleLotScan(context, code);
              }
            },

            onSubmit: () async {
              await viewModel.save();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Document saved!')));
            },
            onDelete: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text(
                        'Are you sure you want to delete this document?',
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
                await viewModel.deleteDoc(context);
                Navigator.pop(context, true);
              }
            },
          );
        },
      ),
    );
  }
}
