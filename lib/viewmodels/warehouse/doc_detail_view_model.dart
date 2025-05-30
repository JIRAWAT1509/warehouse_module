import 'package:flutter/material.dart';
import 'package:warehouse_module/service/local_storage_service.dart';

class DocDetailViewModel with ChangeNotifier {
  final String docNo;
  List<Map<String, dynamic>> items = [];

  double qty1 = 1.0;
  double qty2 = 1.0;
  String location = '';
  String bin = '';

  DocDetailViewModel(this.docNo) {
    loadData();
  }

  Future<void> loadData() async {
    final docs = await LocalStorageService.loadDocuments();
    final doc = docs.cast<Map<String, dynamic>>().firstWhere(
      (d) => d['no'] == docNo,
      orElse: () => <String, dynamic>{},
    );
    if (doc.isNotEmpty) {
      items = (doc['items'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    }

    notifyListeners();
  }

  Future<void> handleItemScan(BuildContext context, String code) async {
    final existing = items.firstWhere(
      (item) =>
          item['itemNo'] == code &&
          item['location'] == location &&
          item['bin'] == bin,
      orElse: () => {},
    );

    if (existing.isNotEmpty) {
      existing['qty'] += qty1;
    } else {
      items.add({
        'itemNo': code,
        'lotNo': '',
        'qty': qty1,
        'location': location,
        'bin': bin,
      });
    }

    // บันทึกลง LocalStorage หลัง scan
    final docs = await LocalStorageService.loadDocuments();
    final index = docs.indexWhere((d) => d['no'] == docNo);
    if (index != -1) {
      docs[index]['items'] = items;
      await LocalStorageService.saveDocuments(docs);
    }

    notifyListeners();
  }

  Future<void> handleLotScan(BuildContext context, String code) async {
    if (items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please scan item first')));
      return;
    }

    items.last['lotNo'] = code;
    notifyListeners();
  }

  void updateForm({
    required double qty1Value,
    required double qty2Value,
    required String locationValue,
    required String binValue,
  }) {
    qty1 = qty1Value;
    qty2 = qty2Value;
    location = locationValue;
    bin = binValue;
  }

  void handleScannedItems(
    BuildContext context,
    List<Map<String, dynamic>> scannedItems,
  ) {
    for (var scannedItem in scannedItems) {
      final existing = items.firstWhere(
        (item) =>
            item['itemNo'] == scannedItem['itemNo'] &&
            item['location'] == location &&
            item['bin'] == bin,
        orElse: () => {},
      );

      if (existing.isNotEmpty) {
        existing['qty'] += scannedItem['qty'] ?? 1;
      } else {
        items.add({
          'itemNo': scannedItem['itemNo'],
          'lotNo': '',
          'qty': scannedItem['qty'] ?? 1,
          'location': location,
          'bin': bin,
        });
      }
    }

    save(context); // บันทึกทันที
    notifyListeners();
  }

  Future<void> save(BuildContext context) async {
    final docs = await LocalStorageService.loadDocuments();
    final index = docs.indexWhere((d) => d['no'] == docNo);
    if (index != -1) {
      docs[index]['items'] = items;
    }
    await LocalStorageService.saveDocuments(docs);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Document saved!')));
  }

  Future<void> deleteDoc(BuildContext context) async {
    final docs = await LocalStorageService.loadDocuments();
    docs.removeWhere((d) => d['no'] == docNo);
    await LocalStorageService.saveDocuments(docs);
    // Navigator.pop(context, true);
    notifyListeners();
  }
}
