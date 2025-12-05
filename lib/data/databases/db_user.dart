import 'package:dzevent/data/databases/db_base.dart';

class UserTable extends DBBaseTable {
  @override
  var dbTable = 'user';
  static String sql_code = '''
          CREATE TABLE  user (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL CHECK (name <> ''),
              email TEXT UNIQUE NOT NULL CHECK (email <> ''),

              profilePicture TEXT,
              createdAt TIMESTAMP NOT NULL CHECK (createdAt <> '')
            );
        ''';
}
