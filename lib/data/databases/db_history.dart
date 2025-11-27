import 'db_base.dart';

class DBHistoryTable extends DBBaseTable {
  DBHistoryTable()
    : super(
        dbTable: 'history',
        sqlCode: '''
          CREATE TABLE  history (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              log timestamp
            )
        ''',
      );
}
