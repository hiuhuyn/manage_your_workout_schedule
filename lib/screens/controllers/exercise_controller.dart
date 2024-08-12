import 'dart:developer';

import 'package:flutter/material.dart';

import '../../model/exercise.dart';
import '../../repository/exercise_repository.dart';

class ExerciseController extends ChangeNotifier {
  final _exerciseRepository = ExerciseRepository();
  List<Exercise> _exercises = [];
  List<Exercise> get exercises => List.from(_exercises);

  void loadExercises(BuildContext context) async {
    try {
      _exercises = await _exerciseRepository.getAllExercises();
      log(_exercises.toList().toString());
      notifyListeners();
    } catch (e) {
      showAboutDialog(context: context, children: [
        Text('Error loading exercises: ${e.toString()}'),
      ]);
    }
  }

  void deleteExercise(Exercise exercise, BuildContext context) async {
    try {
      await _exerciseRepository.deleteExercise(exercise.id!);
      _exercises.remove(exercise);
      notifyListeners();
    } catch (e) {
      showAboutDialog(context: context, children: [
        Text('Error deleting exercise: ${e.toString()}'),
      ]);
    }
  }

  void updateExercise(Exercise exercise, BuildContext context) async {
    try {
      log(exercise.toString());
      await _exerciseRepository.updateExercise(exercise);
      int index = _exercises.indexWhere(
        (element) => element.id == exercise.id,
      );
      if (index != -1) {
        _exercises[index] = exercise;
      } else {
        _exercises.add(exercise);
      }
      notifyListeners();
    } catch (e) {
      showAboutDialog(context: context, children: [
        Text('Error updating exercise: ${e.toString()}'),
      ]);
    }
  }

  void addExercise(Exercise exercise, BuildContext context) async {
    try {
      int id = await _exerciseRepository.insertExercise(exercise);
      exercise.id = id;
      _exercises.add(exercise);
      notifyListeners();
    } catch (e) {
      showAboutDialog(context: context, children: [
        Text('Error adding exercise: ${e.toString()}'),
      ]);
    }
  }
}
