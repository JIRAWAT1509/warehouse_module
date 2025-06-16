import 'package:flutter/material.dart';
import 'package:warehouse_module/service/local_storage_service.dart';

class DocDetailViewModel with ChangeNotifier {
  final String docNo;
  List<Map<String, dynamic>> items = [];

  double qty1 = 1.0;
  double qty2 = 1.0;
  String location = '';
  String bin = '';
  String lotNo = '';

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

  Future<void> handleItemScan(String code) async {
    final existing = items.firstWhere(
      (item) =>
          item['itemNo'] == code &&
          item['location'] == location &&
          item['bin'] == bin &&
          item['lotNo'] == lotNo,
      orElse: () => {},
    );

    if (existing.isNotEmpty) {
      existing['qty'] += qty1;
    } else {
      items.add({
        // 'itemNo': code,
        'lotNo': lotNo,
        // 'qty': qty1,
        'location': location,
        'bin': bin,
      });
    }

    await save();
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
    required String lotNoValue,
  }) {
    qty1 = qty1Value;
    qty2 = qty2Value;
    location = locationValue;
    bin = binValue;
    lotNo = lotNoValue;
  }

  void handleScannedItems(List<Map<String, dynamic>> scannedItems) {
    for (var scannedItem in scannedItems) {
      final existing = items.firstWhere(
        (item) =>
            item['itemNo'] == scannedItem['itemNo'] &&
            item['location'] == scannedItem['location'] &&
            item['bin'] == scannedItem['bin'] &&
            item['lotNo'] == scannedItem['lotNo'],
        orElse: () => {},
      );

      if (existing.isNotEmpty) {
        existing['qty'] += scannedItem['qty'] ?? 1;
      } else {
        items.add({
          'itemNo': scannedItem['itemNo'],
          'lotNo': scannedItem['lotNo'] ?? '',
          'qty': scannedItem['qty'] ?? 1,
          'location': scannedItem['location'] ?? '',
          'bin': scannedItem['bin'] ?? '',
        });
      }
    }

    save(); // Save ทันที แต่ไม่โชว์ SnackBar ที่นี่
  }

  Future<void> save() async {
    final docs = await LocalStorageService.loadDocuments();
    final index = docs.indexWhere((d) => d['no'] == docNo);
    if (index != -1) {
      docs[index]['items'] = items;
    }
    await LocalStorageService.saveDocuments(docs);
    notifyListeners();
  }

  Future<void> deleteDoc(BuildContext context) async {
    final docs = await LocalStorageService.loadDocuments();
    docs.removeWhere((d) => d['no'] == docNo);
    await LocalStorageService.saveDocuments(docs);
    // Navigator.pop(context, true);
    notifyListeners();
  }

  void mergeOrAddQty(Map<String, dynamic> newItem) {
    final index = items.indexWhere(
      (item) =>
          item['itemNo'] == newItem['itemNo'] &&
          (item['lotNo'] ?? '') == (newItem['lotNo'] ?? '') &&
          (item['location'] ?? '') == (newItem['location'] ?? '') &&
          (item['bin'] ?? '') == (newItem['bin'] ?? ''),
    );

    if (index != -1) {
      items[index]['qty'] = (items[index]['qty'] ?? 0) + (newItem['qty'] ?? 0);
    } else {
      items.add(newItem);
    }

    notifyListeners();
  }

  // สำหรับ Replace ค่า (ใช้ตอน Edit Item Page)
  void replaceItem(Map<String, dynamic> updatedItem) {
    final index = items.indexWhere(
      (item) =>
          item['itemNo'] == updatedItem['itemNo'] &&
          (item['lotNo'] ?? '') == (updatedItem['lotNo'] ?? '') &&
          (item['location'] ?? '') == (updatedItem['location'] ?? '') &&
          (item['bin'] ?? '') == (updatedItem['bin'] ?? ''),
    );

    if (index != -1) {
      items[index] = updatedItem;
    } else {
      items.add(updatedItem);
    }

    notifyListeners();
  }

  void updateOrReplaceItem(
    Map<String, dynamic> oldItem,
    Map<String, dynamic> newItem,
  ) {
    final index = items.indexWhere(
      (item) =>
          item['itemNo'] == oldItem['itemNo'] &&
          (item['lotNo'] ?? '') == (oldItem['lotNo'] ?? '') &&
          (item['location'] ?? '') == (oldItem['location'] ?? '') &&
          (item['bin'] ?? '') == (oldItem['bin'] ?? ''),
    );

    if (index != -1) {
      items[index] = newItem;
    } else {
      items.add(newItem);
    }

    notifyListeners();
  }
}
