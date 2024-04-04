import 'package:weather/data/ville_dto.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  static const String _dbName = 'meteo.db';
  static const int _dbVersion = 1;

  static Database? _db;

//A appeler dans le main.dart avec runApp(...);
  static initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + _dbName;
    final Database database = await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _db = database;
  }
}

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE villes (id INTEGER PRIMARY KEY, name TEXT)');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db.execute('ALTER TABLE villes ADD COLUMN population INTEGER');
    }
  }

