import 'package:flutter/material.dart';
import 'package:warehouse_module/core/templates/item_edit_template.dart';

class ItemEditPage extends StatelessWidget {
  final String docNo;
  final String category;
  final Map<String, dynamic> itemData;

  const ItemEditPage({
    super.key,
    required this.docNo,
    required this.category,
    required this.itemData,
  });

  @override
  Widget build(BuildContext context) {
    return ItemEditTemplate(
      docNo: docNo,
      category: category,
      itemData: itemData,
      onSave: () {
        // TODO: Implement save logic
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Saved successfully!')));
        Navigator.pop(context);
      },
    );
  }
}
