// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'exercise.dart';

class TrainingSchedule {
  int? id;
  DateTime start;
  List<Exercise> exerciseList;
  TrainingSchedule({
    this.id,
    required this.start,
    required this.exerciseList,
  });

  TrainingSchedule copyWith({
    int? id,
    DateTime? start,
    List<Exercise>? exerciseList,
  }) {
    return TrainingSchedule(
      id: id ?? this.id,
      start: start ?? this.start,
      exerciseList: exerciseList ?? this.exerciseList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'start': start.millisecondsSinceEpoch,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingSchedule.fromJson(String source) =>
      TrainingSchedule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TrainingSchedule(id: $id, start: $start, exerciseList: $exerciseList)';

  @override
  bool operator ==(covariant TrainingSchedule other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.start == start &&
        listEquals(other.exerciseList, exerciseList);
  }

  @override
  int get hashCode => id.hashCode ^ start.hashCode ^ exerciseList.hashCode;
}
