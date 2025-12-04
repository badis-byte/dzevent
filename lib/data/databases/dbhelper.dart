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
  static var database;

  static List<String> sql_codes = [
    EventsTable.sql_code,
    UserTable.sql_code,
    AssociationTable.sql_code,
  ];
  static Future<Database> getDatabase() async {
    if (database != null) {
      return database;
    }

    database = openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (database, version) {
        for (var item in sql_codes) {
          database.execute(item);
        }
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {
        //do nothing...
      },
    );
    return database;
  }
}
