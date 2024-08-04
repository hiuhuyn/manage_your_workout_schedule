import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../model/exercise.dart';

class ExerciseRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertExercise(Exercise exercise) async {
    final db = await _databaseHelper.database;
    return await db!.insert('exercises', exercise.toMap());
  }

  Future<int> updateExercise(Exercise exercise) async {
    final db = await _databaseHelper.database;
    return await db!.update(
      'exercises',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future<int> deleteExercise(int id) async {
    final db = await _databaseHelper.database;
    return await db!.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Exercise?> getExercise(int id) async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db!.query(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Exercise.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Exercise>> getAllExercises() async {
    final db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db!.query('exercises');

    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }
}
