import 'db_base.dart';

class PostsTable extends DBBaseTable {
  var db_table = 'history';
  static String sql_code = '''
          CREATE TABLE  Events (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              created_at timestamp NOT NULL
            )
        ''';
}
