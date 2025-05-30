import 'package:flutter/material.dart';
import 'package:warehouse_module/core/templates/document_list_template.dart';
import 'package:warehouse_module/views/warehouse/common_barcode_scan_page.dart';
import 'package:warehouse_module/views/warehouse/doc_detail_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_module/viewmodels/warehouse/warehouse_list_view_model.dart';

class WarehouseListPage extends StatefulWidget {
  const WarehouseListPage({super.key});

  @override
  State<WarehouseListPage> createState() => _WarehouseListPageState();
}

class _WarehouseListPageState extends State<WarehouseListPage> {
  late final MobileScannerController scannerController;
  late BuildContext scaffoldContext;

  @override
  void initState() {
    super.initState();

    scannerController = MobileScannerController(
      formats: [
        BarcodeFormat.code128,
        BarcodeFormat.code39,
        BarcodeFormat.ean13,
        BarcodeFormat.ean8,
        BarcodeFormat.upcA,
        BarcodeFormat.upcE,
      ],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WarehouseListViewModel>(
        context,
        listen: false,
      ).loadDocuments();
    });
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WarehouseListViewModel>(context);

    return Builder(
      builder: (context) {
        scaffoldContext = context;
        return DocumentListTemplate(
          title: 'Stocks',
          documents: viewModel.documents,
          onScan: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => MobileScanner(
                      controller: scannerController,
                      onDetect: (capture) async {
                        final code = capture.barcodes.first.rawValue;
                        if (code == null) return;
                        Navigator.pop(context);
                        await viewModel.handleScan(scaffoldContext, code);
                      },
                      onDetectError:
                          (error, stackTrace) => print("Scan error: $error"),
                    ), //Because of different purpose, I prefer this one. I'll extract it to new file later.
              ),
            );
          },
          onItemTap: (item) async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        DocDetailPage(docNo: item['no']?.toString() ?? ''),
              ),
            );
            if (result == true) {
              viewModel.loadDocuments();
            }
          },
        );
      },
    );
  }
}
