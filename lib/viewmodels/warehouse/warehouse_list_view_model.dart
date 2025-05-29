import 'package:flutter/material.dart';
import 'package:warehouse_module/service/local_storage_service.dart';
import 'package:warehouse_module/views/warehouse/doc_detail_page.dart';

class WarehouseListViewModel with ChangeNotifier {
  List<Map<String, dynamic>> _documents = [];

  List<Map<String, dynamic>> get documents => _documents;

  Future<void> loadDocuments() async {
    final data = await LocalStorageService.loadDocuments();
    _documents = data.cast<Map<String, dynamic>>();
    notifyListeners();
  }

  Future<void> saveDocuments() async {
    await LocalStorageService.saveDocuments(_documents);
  }

  Future<void> handleScan(BuildContext context, String scannedCode) async {
    final found = _documents.any((doc) => doc['no'] == scannedCode);

    if (found) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocDetailPage(docNo: scannedCode),
        ),
      );
    } else {
      final result = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Document not found'),
              content: Text(
                'Do you want to add a new document with No: $scannedCode?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Add'),
                ),
              ],
            ),
      );

      if (result == true) {
        final newDoc = {
          'no': scannedCode,
          'date': DateTime.now().toIso8601String().substring(0, 10),
        };
        _documents.add(newDoc);
        await saveDocuments();
        notifyListeners();

        // ใช้ context ปัจจุบันทันที (ไม่ต้อง Future.microtask แล้ว)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocDetailPage(docNo: scannedCode),
          ),
        );
      }
    }
  }
}
