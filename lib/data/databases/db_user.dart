import 'package:dzevent/data/databases/db_base_acc.dart';


class UserTable extends DBBaseTableex {
  var db_table = 'user';
  static String sql_code = '''
          CREATE TABLE  user (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              email TEXT UNIQUE NOT NULL,
              passwordHash TEXT NOT NULL,
              profilePicture TEXT,
              bio TEXT,
              createdAt TIMESTAMP NOT NULL
            );
        ''';
}


