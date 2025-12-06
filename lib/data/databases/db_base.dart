import 'package:dzevent/data/models/assoc_model.dart';
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

  Future<List<Map<String, dynamic>>> getRecordbyId(int id) async {
    try {
      final database = await DBHelper.getDatabase();
      var data = await database.query(
        dbTable,
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

  Future<List<AssociationModel>> getAssociationUnv() async {
    int unv = 0;
    try {
      final db = await DBHelper.getDatabase();
      List<AssociationModel> result = [];
      final associations = await db.rawQuery(
        'SELECT * FROM association WHERE isVerified = 0;',
      );
      print("fetched data : ${associations.toString()}");
      if (associations.isNotEmpty) {
        for (var asso in associations) {
          var association = AssociationModel.fromMap(asso);
          result.add(association);
        }
        return result;
      } else {
        print("result is empty");
        return [];
      }
    } catch (e) {
      print("catch bloc <db_base_file> : something went wrong ******* $e");
      throw Exception("something went wrong !");
    }
  }

  Future<bool> verifyAssociation(int id) async {
    try {
      final db = await DBHelper.getDatabase();

      int updatedRows = await db.update(
        "association",
        {"isVerified": 1},
        where: "id = ?",
        whereArgs: [id],
      );

      return updatedRows > 0;
    } catch (e) {
      print("verifyAssociation error: $e");
      return false;
    }
  }
  Future<bool> deleteAssociation(int id) async {
    try {
      final db = await DBHelper.getDatabase();
      await db.delete("association", where: 'id = ?', whereArgs: [id]);
      return true;
    } on Exception catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }
}
