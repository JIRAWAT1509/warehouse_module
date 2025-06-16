import 'package:flutter/material.dart';
// import 'package:warehouse_module/core/widgets/buttons/scanner_button.dart'; // Add this!

class DocumentListTemplate extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> documents;
  final VoidCallback? onScan;
  final VoidCallback? onBack;
  final Function(Map<String, dynamic>)? onItemTap;

  const DocumentListTemplate({
    Key? key,
    required this.title,
    required this.documents,
    this.onScan,
    this.onBack,
    this.onItemTap,
  }) : super(key: key);

  @override
  State<DocumentListTemplate> createState() => _DocumentListTemplateState();
}

class _DocumentListTemplateState extends State<DocumentListTemplate> {
  String searchText = '';
  bool isAscending = true;

  List<Map<String, dynamic>> get filteredDocs {
    final searchTerm = searchText.toLowerCase();
    List<Map<String, dynamic>> filtered = widget.documents
        .where((doc) => (doc['no']?.toString().toLowerCase().contains(searchTerm) ?? false))
        .toList();

    filtered.sort((a, b) {
      final aNo = a['no']?.toString() ?? '';
      final bNo = b['no']?.toString() ?? '';
      return isAscending ? aNo.compareTo(bNo) : bNo.compareTo(aNo);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchTextField(),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildDocumentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner),
        onPressed: widget.onScan,
      ),
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      decoration: InputDecoration(
        hintText: '${widget.title} No.',
        border: InputBorder.none,
      ),
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildSortableHeaderItem('No.', flex: 2, onTap: () {
            setState(() {
              isAscending = !isAscending;
            });
          }),
          const Expanded(flex: 4, child: Text('Doc No.')),
          const Expanded(flex: 3, child: Text('Date')),
        ],
      ),
    );
  }

  Widget _buildSortableHeaderItem(String title,
      {required int flex, VoidCallback? onTap}) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(title),
            Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentList() {
    return ListView.builder(
      itemCount: filteredDocs.length,
      itemBuilder: (context, index) {
        final doc = filteredDocs[index];
        return _buildDocumentListItem(doc, index);
      },
    );
  }

  Widget _buildDocumentListItem(Map<String, dynamic> doc, int index) {
    return InkWell(
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
    );
  }
}
