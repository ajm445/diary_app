// widgets/memo_tile.dart
import 'package:flutter/material.dart';

class MemoTile extends StatelessWidget {
  final String content;
  const MemoTile({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(content),
    );
  }
}