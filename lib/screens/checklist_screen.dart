// screens/checklist_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/checklist_item.dart';
import '../services/local_storage_service.dart';
import '../widgets/AddChecklistDialog.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final LocalStorageService _storage = LocalStorageService();
  final List<ChecklistItem> _items = [];
  final String _storageKey = 'checklist_items';

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  Future<void> _loadChecklist() async {
    final data = await _storage.loadData(_storageKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      setState(() {
        _items.clear();
        _items.addAll(jsonList.map((e) => ChecklistItem(
          id: e['id'],
          title: e['title'],
          isDone: e['isDone'],
        )));
      });
    }
  }

  Future<void> _saveChecklist() async {
    final jsonStr = jsonEncode(_items.map((e) => {
      'id': e.id,
      'title': e.title,
      'isDone': e.isDone,
    }).toList());
    await _storage.saveData(_storageKey, jsonStr);
  }

  Future<void> _addNewItem() async {
    final title = await showDialog<String>(
      context: context,
      builder: (_) => const AddChecklistDialog(),
    );
    if (title != null && title.isNotEmpty) {
      setState(() {
        _items.add(ChecklistItem(id: const Uuid().v4(), title: title));
      });
      await _saveChecklist();
    }
  }

  void _toggleDone(ChecklistItem item) {
    setState(() => item.isDone = !item.isDone);
    _saveChecklist();
  }

  void _removeItem(ChecklistItem item) {
    setState(() => _items.remove(item));
    _saveChecklist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final item = _items[i];
          return Dismissible(
            key: Key(item.id),
            onDismissed: (_) => _removeItem(item),
            background: Container(color: Colors.red),
            child: CheckboxListTile(
              value: item.isDone,
              title: Text(item.title),
              onChanged: (_) => _toggleDone(item),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
