import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:warehouse_module/core/widgets/buttons/scanner_button.dart';
import 'package:warehouse_module/core/widgets/item_list_widget.dart';
import 'package:warehouse_module/viewmodels/warehouse/doc_detail_view_model.dart';
import 'package:warehouse_module/views/item_edit_page.dart';

class DocumentDetailTemplate extends StatefulWidget {
  final String docNo;
  final DocDetailViewModel viewModel;
  final VoidCallback? onScan;
  final VoidCallback? onSubmit;
  final VoidCallback? onDelete;
  final VoidCallback? onScanItem;
  final VoidCallback? onScanLot;

  const DocumentDetailTemplate({
    super.key,
    required this.docNo,
    required this.viewModel,
    this.onScan,
    this.onSubmit,
    this.onDelete,
    this.onScanItem,
    this.onScanLot,
  });

  @override
  State<DocumentDetailTemplate> createState() => _DocumentDetailTemplateState();
}

class _DocumentDetailTemplateState extends State<DocumentDetailTemplate> {
  final TextEditingController qty1Controller = TextEditingController();
  final TextEditingController qty2Controller = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController binController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController lotController = TextEditingController();

  void _showAddItemDialog(BuildContext context) {
    final TextEditingController itemNoController = TextEditingController();
    final TextEditingController lotNoController = TextEditingController();
    final TextEditingController qtyController = TextEditingController(
      text: '1',
    );
    final TextEditingController locationController = TextEditingController();
    final TextEditingController binController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Item'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: itemNoController,
                    decoration: const InputDecoration(labelText: 'Item No'),
                  ),
                  TextField(
                    controller: lotNoController,
                    decoration: const InputDecoration(labelText: 'Lot No'),
                  ),
                  TextField(
                    controller: qtyController,
                    decoration: const InputDecoration(labelText: 'Qty'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  TextField(
                    controller: binController,
                    decoration: const InputDecoration(labelText: 'Bin'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                // onPressed: () {
                //   final newItem = {
                //     'itemNo': itemNoController.text,
                //     'lotNo': lotNoController.text,
                //     'qty': double.tryParse(qtyController.text) ?? 1.0,
                //     'location': locationController.text,
                //     'bin': binController.text,
                //   };

                //   widget.viewModel.mergeOrAddQty(newItem);
                //   widget.viewModel.save();

                //   widget.viewModel.notifyListeners();
                //   Navigator.pop(context);
                // }
                // ,
                onPressed: () {
                  final itemNo = itemNoController.text.trim();
                  final lotNo = lotNoController.text.trim();
                  final location = locationController.text.trim();
                  final bin = binController.text.trim();
                  final qty = double.tryParse(qtyController.text) ?? 1.0;

                  final newItem = {
                    'itemNo': itemNo,
                    'lotNo': lotNo,
                    'qty': qty,
                    'location': location,
                    'bin': bin,
                  };

                  widget.viewModel.mergeOrAddQty(newItem);
                  widget.viewModel.save();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('Document No: ${widget.docNo}')),
            // ScannerButton(onPressed: widget.onScan),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            //1feildperline
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: qty1Controller,
                        decoration: const InputDecoration(labelText: 'Qty 1'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: qty2Controller,
                        decoration: const InputDecoration(labelText: 'Qty 2'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: binController,
                        decoration: const InputDecoration(labelText: 'Bin No.'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: itemController,
                        decoration: const InputDecoration(
                          labelText: 'Item No.',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: lotController,
                        decoration: const InputDecoration(labelText: 'Lot No.'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Item'),
            onPressed: () {
              final itemNo = itemController.text.trim();
              final lotNo = lotController.text.trim();
              final location = locationController.text.trim();
              final bin = binController.text.trim();
              final qty1 = double.tryParse(qty1Controller.text) ?? 1.0;
              final qty2 = double.tryParse(qty2Controller.text) ?? 1.0;
              final totalQty = qty1 == qty2 ? qty1 : false;

              if (itemNo.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter Item No.')),
                );
                return;
              }

              if (totalQty == false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please enter the same amount of qty1 and qty2',
                    ),
                  ),
                );
                return;
              }
              final newItem = {
                'itemNo': itemNo,
                'lotNo': lotNo,
                'qty': totalQty,
                'location': location,
                'bin': bin,
              };

              widget.viewModel.items.add(newItem);
              widget.viewModel.save();
              widget.viewModel.notifyListeners();

              // Clear fields after add
              itemController.clear();
              lotController.clear();
              qty1Controller.text = '1';
              qty2Controller.text = '1';
            },
          ),

          Expanded(
            child: Consumer<DocDetailViewModel>(
              builder: (context, viewModel, _) {
                return ItemListWidget(
                  items: viewModel.items,
                  onItemTap: (item) async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemEditPage(item: item),
                      ),
                    );

                    if (result != null && result['action'] == 'confirm') {
                      widget.viewModel.updateOrReplaceItem(
                        result['oldItem'],
                        result['item'],
                      );
                      await widget.viewModel.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item updated!')),
                      );
                    } else if (result != null && result['action'] == 'delete') {
                      widget.viewModel.items.remove(item);
                      await widget.viewModel.save();
                      widget.viewModel.notifyListeners();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted!')),
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: widget.onSubmit ?? () {},
              child: const Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: widget.onDelete,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'itemScan',
            // onPressed: widget.onScanItem,
            onPressed: () {
              final location = locationController.text.trim();
              final bin = binController.text.trim();
              final qty1 = double.tryParse(qty1Controller.text) ?? 1.0;
              final qty2 = double.tryParse(qty2Controller.text) ?? 1.0;

              widget.viewModel.updateForm(
                qty1Value: qty1,
                qty2Value: qty2,
                locationValue: location,
                binValue: bin,
              );

              widget.onScanItem?.call();
            },
            child: const Icon(Icons.qr_code_scanner),
            tooltip: 'Scan Item',
          ),
        ],
      ),
    );
  }
}
