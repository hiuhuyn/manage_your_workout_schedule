import 'dart:async';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import '../database/database_helper.dart';
import '../model/notification_training.dart';

class NotificationTrainingRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertNotification(NotificationTraining notification) async {
    final db = await _databaseHelper.database;
    return await db!.insert(
      'notification_training',
      notification.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNotification(NotificationTraining notification) async {
    final db = await _databaseHelper.database;
    await db!.update(
      'notification_training',
      notification.toMap(),
      where: 'id = ?',
      whereArgs: [notification.id],
    );
  }

  Future<void> deleteNotification(int id) async {
    final db = await _databaseHelper.database;
    await db!.delete(
      'notification_training',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<NotificationTraining>> getAllNotifications() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
        await db!.query('notification_training');

    return List.generate(maps.length, (i) {
      return NotificationTraining.fromMap(maps[i]);
    });
  }
}
