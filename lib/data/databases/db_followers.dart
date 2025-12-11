import 'package:dzevent/data/databases/db_base.dart';
import 'package:dzevent/data/databases/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

class FollowersTable extends DBBaseTable {
  @override
  var db_table = 'followers';
  static String sql_code = '''
          CREATE TABLE followers (
              id              INTEGER PRIMARY KEY AUTOINCREMENT,
              user_id         INTEGER NOT NULL,
              association_id  INTEGER NOT NULL,
              notify          BOOLEAN DEFAULT 1,
            );
        ''';


    Future<List<int>> getFollowedAssociations(int userId) async {
      try{  
        final db = await DBHelper.getDatabase();
        final result = await db.query(
          db_table,
          where: 'user_id = ?',
          whereArgs: [userId],
        );
         return result.map((row) => row['association_id'] as int).toList();
      }catch(e){
        rethrow;
      }
    }


      Future<bool> follow(int userId, int associationId) async {
        try{
          final db = await DBHelper.getDatabase();
          await db.insert(
          db_table,
          {
            'user_id': userId,
            'association_id': associationId,
            'notify': 1,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
          );
          return true;
        }catch(e){
          rethrow;
        }
      }


      Future<bool> unfollow(int userId, int associationId) async {
        try{
        final db = await DBHelper.getDatabase();
        final count = await db.delete(
          db_table,
          where: 'user_id = ? AND association_id = ?',
          whereArgs: [userId, associationId],
          );
          return count > 0;
        }catch(e){
          rethrow;
        }
      }

      Future<int> getFollowers(int assocaiationId) async{
        try{
            final db = await DBHelper.getDatabase();
            final count = await db.query(db_table,
            where: 'association_id = ?',
            whereArgs: [assocaiationId],
            );
            final last = count.map((row) => row['association_id'] as int).toList();
            return last.length;
        }catch(e){
          rethrow;
        }
      }


}