import 'package:dzevent/data/databases/db_base_acc.dart';


class AssociationTable extends DBBaseTableex {
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

