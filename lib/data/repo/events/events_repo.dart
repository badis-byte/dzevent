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
  Future<List<EventModel>> getFilteredEvents({
    required List<String> filters,
  }) async {
    if (filters.isEmpty) {
      return await getData();
    }
    final placeholders = List.filled(
      filters.length,
      '?',
    ).join(' OR category = ');
    final obj = await eventsTable.getRecords(
      where: 'category = $placeholders',
      whereArgs: filters,
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
