import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _docKey = 'documents';

  static Future<void> saveDocuments(List<Map<String, dynamic>> docs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(docs);
    await prefs.setString(_docKey, jsonString);
  }

  static Future<List<Map<String, dynamic>>> loadDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_docKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.cast<Map<String, dynamic>>();
  }
}
