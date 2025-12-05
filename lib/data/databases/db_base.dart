import 'package:sqflite/sqflite.dart';

import 'dbhelper.dart';

class DBBaseTable {
  var dbTable = 'TABLE_NAME_MUST_OVERRIDE';

  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      database.insert(
        dbTable,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<bool> deleteRecord(String id) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.delete(dbTable, where: 'id = ?', whereArgs: [id]);
      return true;
    } on Exception catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getRecords() async {
    try {
      final database = await DBHelper.getDatabase();
      var data = await database.rawQuery(
        "select * from $dbTable order by id DESC",
      );
      return data;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return [];
  }

  Future<bool> deleteRecords() async {
    try {
      final db = await DBHelper.getDatabase();
      await db.delete(dbTable);
      return true;
    } on Exception catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<bool> updateRecord(Map<String, dynamic> data, String id) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.update(
        dbTable,
        data,
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return false;
    }
  }
}
