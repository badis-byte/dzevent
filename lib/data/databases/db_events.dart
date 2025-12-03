import 'db_base.dart';

class EventsTable extends DBBaseTable {
  var db_table = 'events';

  static String sql_code = '''
    CREATE TABLE events (
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      startDatetime TEXT NOT NULL,
      endDatetime TEXT NOT NULL,
      imageUrl TEXT,
      location TEXT,
      createdAt TEXT NOT NULL,
      associationId INTEGER,
      category TEXT
    );
  ''';
}
