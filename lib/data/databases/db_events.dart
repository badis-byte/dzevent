import 'db_base.dart';

class EventsTable extends DBBaseTable {
  var db_table = 'events';

  static String sql_code = '''
    CREATE TABLE events (
      id TEXT PRIMARY KEY CHECK (id <> ''),
      title TEXT NOT NULL UNIQUE CHECK (title <> ''),
      description TEXT NOT NULL CHECK (description <> ''),
      startDatetime TEXT NOT NULL CHECK (startDatetime <> ''),
      endDatetime TEXT NOT NULL CHECK (endDatetime <> ''),
      imageUrl TEXT NOT NULL CHECK (imageUrl <> ''),
      location TEXT NOT NULL CHECK (location <> ''),
      createdAt TEXT NOT NULL CHECK (createdAt <> ''),
      associationId INTEGER,
      category TEXT NOT NULL CHECK (category <> '')
);

  ''';
}
