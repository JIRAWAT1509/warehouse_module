import 'package:flutter/material.dart';

class ItemListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final void Function(Map<String, dynamic> item)? onItemTap;

  const ItemListWidget({super.key, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: const [
              Expanded(flex: 2, child: Text('No.')),
              Expanded(flex: 4, child: Text('Item')),
              Expanded(flex: 3, child: Text('Lot no.')),
              Expanded(flex: 2, child: Text('Qty')),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () => onItemTap?.call(item), // แค่ call callback
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text('${index + 1}')),
                      Expanded(flex: 4, child: Text(item['itemNo'] ?? '')),
                      Expanded(flex: 3, child: Text(item['lotNo'] ?? '')),
                      Expanded(
                        flex: 2,
                        child: Text(item['qty']?.toString() ?? ''),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
