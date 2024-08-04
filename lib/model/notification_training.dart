// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationTraining {
  int? id;
  String? name;
  DateTime? start;
  NotificationTraining({
    this.id,
    this.name,
    this.start,
  });

  NotificationTraining copyWith({
    int? id,
    String? name,
    DateTime? start,
  }) {
    return NotificationTraining(
      id: id ?? this.id,
      name: name ?? this.name,
      start: start ?? this.start,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'start': start?.millisecondsSinceEpoch,
    };
  }

  factory NotificationTraining.fromMap(Map<String, dynamic> map) {
    return NotificationTraining(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      start: map['start'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['start'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationTraining.fromJson(String source) =>
      NotificationTraining.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificationTraining(id: $id, name: $name, start: $start)';
}
