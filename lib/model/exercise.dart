// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Exercise {
  int? id;
  String name;
  int count;
  bool isCompleted;
  Exercise({
    this.id,
    required this.name,
    required this.count,
    this.isCompleted = false,
  });

  Exercise copyWith({
    int? id,
    String? name,
    int? count,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'count': count,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      count: map['count'] as int,
      isCompleted: map['isCompleted'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Exercise(id: $id, name: $name, count: $count, isCompleted: $isCompleted)';

  @override
  bool operator ==(covariant Exercise other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ count.hashCode;
}
