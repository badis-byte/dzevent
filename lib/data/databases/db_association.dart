import 'package:dzevent/data/databases/db_base.dart';

class AssociationTable extends DBBaseTable {
  var db_table = 'association';
  static String sql_code = '''
          CREATE TABLE  association (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              email VARCHAR(255) UNIQUE NOT NULL,
              passwordHash TEXT NOT NULL,
              profilePicture TEXT,
              bio TEXT,
              createdAt TIMESTAMP NOT NULL,
              verified BOOLEAN NOT NULL DEFAULT FALSE
            );
        ''';
}
