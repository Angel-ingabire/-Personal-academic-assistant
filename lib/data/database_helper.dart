import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite helper for the "advanced" data storage approach.
///
/// Member D owns this file and can flesh out full CRUD logic for
/// assignments, sessions, and attendance history.
class DatabaseHelper {
  static const _dbName = 'academic_assistant.db';
  static const _dbVersion = 1;

  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        // TODO(Member D): Create tables for assignments, sessions, attendance.
      },
    );
  }
}

