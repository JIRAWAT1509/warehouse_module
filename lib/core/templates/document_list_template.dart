import 'package:flutter/material.dart';
// import 'package:warehouse_module/core/widgets/buttons/scanner_button.dart'; // Add this!

class DocumentListTemplate extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> documents;
  final VoidCallback? onScan;
  final VoidCallback? onBack;

  final Function(Map<String, dynamic>)? onItemTap;

  const DocumentListTemplate({
    super.key,
    required this.title,
    required this.documents,
    this.onScan,
    this.onBack,
    this.onItemTap,
  });

  @override
  State<DocumentListTemplate> createState() => _DocumentListTemplateState();
}

class _DocumentListTemplateState extends State<DocumentListTemplate> {
  String searchText = '';
  bool isAscending = true;

  List<Map<String, dynamic>> get filteredDocs {
    var filtered =
        widget.documents.where((doc) {
          return doc['no']?.toString().toLowerCase().contains(
                searchText.toLowerCase(),
              ) ??
              false;
        }).toList();

    filtered.sort((a, b) {
      return isAscending
          ? a['no']?.toString().compareTo(b['no']?.toString() ?? '') ?? 0
          : b['no']?.toString().compareTo(a['no']?.toString() ?? '') ?? 0;
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: widget.onBack ?? () => Navigator.pop(context),
        // ),
        title: TextField(
          decoration: InputDecoration(
            hintText: '${widget.title} No.',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAscending = !isAscending;
                      });
                    },
                    child: Row(
                      children: [
                        const Text('No.'),
                        Icon(
                          isAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 4, child: Text('Doc No.')),
                const Expanded(flex: 3, child: Text('Date')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                final doc = filteredDocs[index];
                return Container(
                  child: InkWell(
                    onTap: () => widget.onItemTap?.call(doc),
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
                          Expanded(
                            flex: 4,
                            child: Text(doc['no']?.toString() ?? ''),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(doc['date']?.toString() ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],

        // actions: [ScannerButton(onPressed: widget.onScan)],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner),
        onPressed: widget.onScan,
      ),
    );
  }
}
