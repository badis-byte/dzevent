import 'package:dzevent/data/models/event_model.dart';

import 'events_repo.dart';

abstract class EventsRepoBase {
  Future<List<EventModel>> getData();
  Future<List<EventModel>> getUserEvents(int id);
  Future<bool> insertData(EventModel value);
  Future<bool> deleteAllData();
  Future<bool> updateRecord(EventModel value, String id);
  Future<bool> deleteRecord(String id);

  static EventsRepoBase? _historyInstance;

  static EventsRepoBase getInstance() {
    _historyInstance ??= EventsRepo();
    return _historyInstance!; // For backend data
  }
}
