import 'dart:async';
import 'package:dzevent/data/databases/db_user.dart';
import 'package:dzevent/data/databases/db_association.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db_events.dart';

class DBHelper {
  static const _database_name = "dzevent_db.db";
  static const _database_version = 1;

  static Database? _db;

  static List<String> sql_codes = [
    EventsTable.sql_code,
    UserTable.sql_code,
    AssociationTable.sql_code,
  ];

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), _database_name);

    _db = await openDatabase(
      path,
      version: _database_version,
      onCreate: (db, version) async {
        for (var item in sql_codes) {
          await db.execute(item);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Example: recreate all tables if version changes
        for (var item in sql_codes) {
          await db.execute(item);
        }
      },
    );

    return _db!;
  }
}
