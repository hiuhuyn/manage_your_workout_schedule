// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'exercise.dart';

class TrainingSchedule {
  int? id;
  String? title;
  DateTime? start;
  List<Exercise> exerciseList;
  TrainingSchedule({
    this.id,
    this.start,
    required this.exerciseList,
    this.title,
  });

  TrainingSchedule copyWith({
    int? id,
    DateTime? start,
    String? title,
    List<Exercise>? exerciseList,
  }) {
    return TrainingSchedule(
      id: id ?? this.id,
      start: start ?? this.start,
      exerciseList: exerciseList ?? this.exerciseList,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'start': start?.millisecondsSinceEpoch,
      'title': title,
    };
  }

  factory TrainingSchedule.fromMap(Map<String, dynamic> map) {
    return TrainingSchedule(
      id: map['id'] != null ? map['id'] as int : null,
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      exerciseList: List<Exercise>.from(
        (map['exerciseList'] as List<int>).map<Exercise>(
          (x) => Exercise.fromMap(x as Map<String, dynamic>),
        ),
      ),
      title: map['title'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingSchedule.fromJson(String source) =>
      TrainingSchedule.fromMap(json.decode(source) as Map<String, dynamic>);
}
