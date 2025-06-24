// models/checklist_item.dart
class ChecklistItem {
  final String id;
  final String title;
  bool isDone;

  ChecklistItem({required this.id, required this.title, this.isDone = false});
}