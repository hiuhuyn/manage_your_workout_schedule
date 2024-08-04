import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'exercise_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE exercises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            count INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE training_schedules (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            start INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE training_schedule_exercises (
            training_schedule_id INTEGER,
            exercise_id INTEGER,
            FOREIGN KEY (training_schedule_id) REFERENCES training_schedules (id),
            FOREIGN KEY (exercise_id) REFERENCES exercises (id)
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> close() async {
    final db = await database;
    db?.close();
  }
}
