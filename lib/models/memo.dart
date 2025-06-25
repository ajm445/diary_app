// models/memo.dart
class Memo {
  final String id;
  final DateTime date;
  final String content;
  final String? imagePath;

  Memo({
    required this.id,
    required this.date,
    required this.content,
    this.imagePath,
  });

  factory Memo.fromJson(Map<String, dynamic> json) => Memo(
    id: json['id'],
    date: DateTime.parse(json['date']),
    content: json['content'],
    imagePath: json['imagePath'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'content': content,
    'imagePath': imagePath,
  };
}
