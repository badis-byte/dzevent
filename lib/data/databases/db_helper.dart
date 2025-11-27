import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DBHelper {
  static const _databaseName = "IncrementHistoryV1.db";
  static const _databaseVersion = 1;
  static Database? database;

  static List<String> sqlCodes = [];
  static bool addSqlCodeEntry({required String sqlCode}) {
    sqlCodes.add(sqlCode);
    return true;
  }

  static Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (database, version) {
        sqlCodes.forEach((item) {
          database.execute(item);
        });
      },
      version: _databaseVersion,
      onUpgrade: (db, oldVersion, newVersion) {
        //do nothing...
      },
    );
    return database!;
  }
}
