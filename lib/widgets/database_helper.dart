import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

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
      onCreate: (db, version) {
        return db.execute(

          'CREATE TABLE customers(id INTEGER PRIMARY KEY, name TEXT, lead TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertCustomer(String name, String lead) async {
    final Database db = await database;

    // Insert the customer into the correct table
    await db.insert(
      'customers',
      {'name': name, 'lead': lead},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getCustomers() async {
    final Database db = await database;

    // Query the table for all customers
    return await db.query('customers');
  }

  static Future<void> _logDatabasePath() async {
    final path = await getDatabasesPath();
    print('Database Path: $path');
  }
}