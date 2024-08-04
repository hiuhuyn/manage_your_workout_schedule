// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Exercise {
  int? id;
  String name;
  int count;
  Exercise({
    this.id,
    required this.name,
    required this.count,
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'count': count,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) => Exercise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Exercise(id: $id, name: $name, count: $count)';

  @override
  bool operator ==(covariant Exercise other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ count.hashCode;
}
