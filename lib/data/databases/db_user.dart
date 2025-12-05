import 'package:dzevent/data/databases/db_base.dart';

class UserTable extends DBBaseTable {
  var db_table = 'user';
  static String sql_code = '''
          CREATE TABLE  user (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              email TEXT UNIQUE NOT NULL,
              passwordHash TEXT NOT NULL,
              profilePicture TEXT,

              createdAt TIMESTAMP NOT NULL
            );
        ''';
}
