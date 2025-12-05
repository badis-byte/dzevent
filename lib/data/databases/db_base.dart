import 'package:sqflite/sqflite.dart';

import 'dbhelper.dart';

class DBBaseTable {
  var db_table = 'TABLE_NAME_MUST_OVERRIDE';

  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      final isInserted =
          await database.insert(
            db_table,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          ) !=
          0;
      return isInserted;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<bool> deleteRecord(String id) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.delete(db_table, where: 'id = ?', whereArgs: [id]);
      return true;
    } on Exception catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getRecordbyId(int id) async {
    try {
      final database = await DBHelper.getDatabase();
      var data = await database.query(
        db_table,
        where: 'associationId = ?',
        whereArgs: [id],
      );
      return data;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getRecords() async {
    try {
      final database = await DBHelper.getDatabase();
      var data = await database.rawQuery(
        "select * from $db_table order by id DESC",
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
      await db.delete(db_table);
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
        db_table,
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
