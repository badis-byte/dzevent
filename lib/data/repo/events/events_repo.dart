import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/repo/events/event_repo_base.dart';

import '../../databases/db_events.dart';

class EventsRepo extends PostRepoBase {
  final postTable = EventsTable(); // Badly Coupled..

  @override
  Future<List<EventModel>> getData() async {
    final obj = await postTable.getRecords();
    List<EventModel> result = [];
    for (var item in obj) {
      result.add(EventModel.fromMap(item));
    }
    return result;
  }

  @override
  Future<List<EventModel>> getUserEvents(int id) async {
    final obj = await postTable.getRecordbyId(id);
    List<EventModel> result = [];
    for (var item in obj) {
      result.add(EventModel.fromMap(item));
    }
    return result;
  }

  @override
  Future<bool> insertData(EventModel post) async {
    final isInserted = postTable.insertRecord(post.toMap());
    return isInserted;
  }

  @override
  Future<bool> updateRecord(EventModel value, String id) async {
    return postTable.updateRecord(value.toMap(), id);
  }

  @override
  Future<bool> deleteAllData() async {
    return postTable.deleteRecords();
  }

  @override
  Future<bool> deleteRecord(String id) async {
    return postTable.deleteRecord(id);
  }
}
