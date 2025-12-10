import 'package:dzevent/data/databases/db_base.dart';
import 'package:dzevent/data/databases/dbhelper.dart';
import 'package:dzevent/data/models/interest_model.dart';

class InterestsTable extends DBBaseTable {
  @override
  var db_table = "interests";

  static var sql_code = """
    CREATE TABLE interests (
    userId INTEGER NOT NULL,
    eventId TEXT NOT NULL CHECK (eventId <> ''),
    createdAt TEXT NOT NULL CHECK (createdAt <> ''),
    
    PRIMARY KEY (userId, eventId),
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (eventId) REFERENCES events(id) ON DELETE CASCADE
);
""";

  Future<bool> deleteInterest(int userId, String eventId) async {
    try {
      final db = await DBHelper.getDatabase();
      final deletedCount = await db.delete(
        "interests",
        where: 'userId = ? AND eventId = ?',
        whereArgs: [userId, eventId],
      );
      if (deletedCount == 0) {
        return false; // not found
      } else if (deletedCount == 1) {
        return true;
      } else {
        throw Exception("(DELETE): Many interest records with the same id");
      }
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getUserInterests({
    required int userId,
  }) async {
    try {
      final db = await DBHelper.getDatabase();
      final records = await db.query(
        'interests',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      return records;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getInterest({
    required int userId,
    required String eventId,
  }) async {
    try {
      final db = await DBHelper.getDatabase();
      final records = await db.query(
        'interests',
        where: 'userId = ? AND eventId = ?',
        whereArgs: [userId, eventId],
      );
      if (records.isEmpty) {
        return null;
      } else if (records.length == 1) {
        return records[0];
      } else {
        throw Exception("(GET): Many interest records with the same id");
      }
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
      return null;
    }
  }
}
