import '../database/database_helper.dart';
import '../model/exercise.dart';
import '../model/training_schedule.dart';
import 'exercise_repository.dart';

class TrainingScheduleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertTrainingSchedule(TrainingSchedule trainingSchedule) async {
    final db = await _databaseHelper.database;
    int id = await db!.insert('training_schedules', trainingSchedule.toMap());

    for (var exercise in trainingSchedule.exerciseList) {
      await db.insert('training_schedule_exercises', {
        'training_schedule_id': id,
        'exercise_id': exercise.id,
      });
    }

    return id;
  }

  Future<int> updateTrainingSchedule(TrainingSchedule trainingSchedule) async {
    final db = await _databaseHelper.database;
    await db!.update(
      'training_schedules',
      trainingSchedule.toMap(),
      where: 'id = ?',
      whereArgs: [trainingSchedule.id],
    );

    await db.delete(
      'training_schedule_exercises',
      where: 'training_schedule_id = ?',
      whereArgs: [trainingSchedule.id],
    );

    for (var exercise in trainingSchedule.exerciseList) {
      await db.insert('training_schedule_exercises', {
        'training_schedule_id': trainingSchedule.id,
        'exercise_id': exercise.id,
      });
    }

    return trainingSchedule.id!;
  }

  Future<int> deleteTrainingSchedule(int id) async {
    final db = await _databaseHelper.database;

    await db!.delete(
      'training_schedule_exercises',
      where: 'training_schedule_id = ?',
      whereArgs: [id],
    );

    return await db.delete(
      'training_schedules',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<TrainingSchedule?> getTrainingSchedule(int id) async {
    final db = await _databaseHelper.database;

    List<Map<String, dynamic>> maps = await db!.query(
      'training_schedules',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      List<Map<String, dynamic>> exerciseMaps = await db.query(
        'training_schedule_exercises',
        where: 'training_schedule_id = ?',
        whereArgs: [id],
      );

      List<Exercise> exercises = [];
      for (var map in exerciseMaps) {
        int exerciseId = map['exercise_id'] as int;
        var exercise = await ExerciseRepository().getExercise(exerciseId);
        if (exercise != null) {
          exercises.add(exercise);
        }
      }

      return TrainingSchedule(
        id: maps.first['id'],
        start: DateTime.fromMillisecondsSinceEpoch(maps.first['start']),
        exerciseList: exercises,
      );
    }
    return null;
  }

  Future<List<TrainingSchedule>> getAllTrainingSchedules() async {
    final db = await _databaseHelper.database;

    List<Map<String, dynamic>> maps = await db!.query('training_schedules');

    List<TrainingSchedule> schedules = [];
    for (var map in maps) {
      int id = map['id'] as int;
      var schedule = await getTrainingSchedule(id);
      if (schedule != null) {
        schedules.add(schedule);
      }
    }

    return schedules;
  }
}
