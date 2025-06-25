// widgets/checklist_tile.dart
import 'package:flutter/material.dart';

class ChecklistTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final void Function(bool?) onChanged;

  const ChecklistTile({
    super.key,
    required this.title,
    required this.isDone,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: isDone,
      onChanged: onChanged,
    );
  }
}