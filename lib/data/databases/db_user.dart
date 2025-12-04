import 'db_base.dart';

class UserTable extends DBBaseTable {
  var db_table = 'association';
  static String sql_code = '''
          CREATE TABLE  Events (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              email VARCHAR(255) UNIQUE NOT NULL,
              password_hash TEXT NOT NULL,
              profile_picture TEXT,
              bio TEXT,
              created_at TIMESTAMP NOT NULL,
            )
        ''';
}


