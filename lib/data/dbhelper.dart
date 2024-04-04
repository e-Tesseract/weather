import 'package:weather/data/ville_dto.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  static const String _dbName = 'meteo.db';
  static const int _dbVersion = 1;
  static const String tableName = 'villes';

  static Database? _db;

  static initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + _dbName;
    final Database database = await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _db = database;
  }

  static void insert(final VilleDTO w) {
    _db!.insert(tableName, w.toMap());
  }

  static Future<List<VilleDTO>>  findAll() async {
    final List<Map<String, Object?>> query = await _db!.query(tableName);
    return query.map((item) => VilleDTO.fromMap(item)).toList();
  }

  static _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT)');
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db.execute('ALTER TABLE $tableName ADD COLUMN pays string');
    }
  }

  static Future<void> delete(int id) async {
    await _db!.execute(
      'DELETE FROM $tableName WHERE id = ?', [id],
    );
  }
}