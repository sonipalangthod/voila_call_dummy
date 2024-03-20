import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String usersTableName = 'users';
  static const String customersTableName = 'customers';

  static Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }


  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    print('Database path: $path'); // Log the database path
    return openDatabase(
      path,
      onCreate: (db, version) async {
        print('Creating tables...'); // Log table creation
        await db.execute(
          'CREATE TABLE $usersTableName(username TEXT PRIMARY KEY, email TEXT, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE $customersTableName(id INTEGER PRIMARY KEY, name TEXT, lead TEXT)',
        );
      },
      version: 1,
    );
  }



  static Future<void> insertUser(Map<String, dynamic> user) async {
    final Database db = await database;
    await db.insert(usersTableName, user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final Database db = await database;
    return db.query(usersTableName);
  }

  static Future<void> insertCustomer(String name, String lead) async {
    final Database db = await database;
    await db.insert(
      customersTableName,
      {'name': name, 'lead': lead},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> getLeadCount(String leadType) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      customersTableName,
      where: 'lead = ?',
      whereArgs: [leadType],
    );
    return result.length;
  }

  static Future<int> getTotalCustomersCount() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(customersTableName);
    return result.length;
  }
}
