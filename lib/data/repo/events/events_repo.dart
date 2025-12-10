import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/repo/events/event_repo_base.dart';

import '../../databases/db_events.dart';

class EventsRepo extends EventsRepoBase {
  final eventsTable = EventsTable(); // Badly Coupled..

  @override
  Future<List<EventModel>> getData() async {
    final obj = await eventsTable.getAllRecords();
    List<EventModel> result = [];
    for (var item in obj) {
      result.add(EventModel.fromMap(item));
    }
    return result;
  }

  @override
  Future<List<EventModel>> getUserEvents(int id) async {
    final obj = await eventsTable.getRecordbyId(id);
    List<EventModel> result = [];
    for (var item in obj) {
      result.add(EventModel.fromMap(item));
    }
    return result;
  }

  @override
  Future<bool> insertData(EventModel post) async {
    final isInserted = eventsTable.insertRecord(post.toMap());
    return isInserted;
  }

  @override
  Future<bool> updateRecord(EventModel value, String id) async {
    return eventsTable.updateRecord(value.toMap(), id);
  }

  @override
  Future<bool> deleteAllData() async {
    return eventsTable.deleteRecords();
  }

  @override
  Future<bool> deleteRecord(String id) async {
    return eventsTable.deleteRecord(id);
  }

  @override
  Future<EventModel?> getEvent({required String id}) async {
    final obj = await eventsTable.getRecord(where: 'id = ?', whereArgs: [id]);
    if (obj == null) {
      return null;
    }
    return EventModel.fromMap(obj);
  }

  @override
  Future<List<EventModel>> getEventByFilter({required String filter}) async {
    final obj = await eventsTable.getRecords(
      where: 'category = ?',
      whereArgs: [filter],
    );
    // print(obj ?? "object is null");
    if (obj == null) {
      return [];
    }
    if (obj.isEmpty) {
      return [];
    }
    List<EventModel> result = [];
    for (var event in obj) {
      result.add(EventModel.fromMap(event));
    }
    return result;
  }

  @override
  Future<List<EventModel>> searchEvents({required String searchStr}) async {
    final obj = await eventsTable.getRecords(
      where: "title LIKE ?",
      whereArgs: ["%$searchStr%"],
    );
    if (obj == null) {
      return [];
    }
    if (obj.isEmpty) {
      return [];
    }
    List<EventModel> result = [];
    for (var event in obj) {
      result.add(EventModel.fromMap(event));
    }
    return result;
  }
}
