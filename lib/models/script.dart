import 'package:cloud_firestore/cloud_firestore.dart';

class Script {
  String id;
  String title;
  String content;
  final DateTime createdAt;
  DateTime updatedAt;

  Script({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

factory Script.fromMap(Map<String, dynamic> map) {
  return Script(
    id: map['id'] as String,
    title: map['title'] as String,
    content: map['content'] as String,
    createdAt: (map['createdAt'] as Timestamp).toDate(),
    updatedAt: (map['updatedAt'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };
}
}