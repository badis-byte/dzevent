import 'package:dzevent/data/databases/db_base.dart';

class AssociationTable extends DBBaseTable {
  @override
  var db_table = 'associations';

  static String sql_code = '''
          CREATE TABLE associations (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL CHECK (name <> ''),
              email TEXT UNIQUE NOT NULL CHECK (email <> ''),
              password TEXT UNIQUE NOT NULL CHECK (email <> ''),
              profilePicture TEXT,
              bio TEXT NOT NULL CHECK (bio <> ''),
              createdAt TIMESTAMP NOT NULL CHECK (createdAt <> ''),
              isVerified INTEGER NOT NULL DEFAULT FALSE
            );
        ''';
}
