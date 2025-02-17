import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "define_digital_database.db");

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE IF NOT EXISTS savings_history (
          company_name TEXT ,
          description TEXT,
          amount NUMBER,
          transaction_date TEXT
        )
      ''');
    });

    return _database!;
  }

  Future<int> insertSavingHistory(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('savings_history', row);
  }

  Future<List<Map<String, dynamic>>> getSavingHistoryByCompanyName(
      String companyName, String description,
      {String year = ""}) async {
    String whereCondition = 'company_name = ? AND description = ?';
    List<Object> whereArgs = [companyName, description];
    if (year.isNotEmpty) {
      whereCondition += ' AND transaction_date LIKE ?';
      whereArgs.add('%$year%');
    }
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'savings_history',
      where: whereCondition,
      whereArgs: whereArgs,
    );
    return result.isNotEmpty ? result : [];
  }
}
