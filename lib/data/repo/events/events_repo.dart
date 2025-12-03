import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/repo/events/event_repo_base.dart';

import '../../databases/db_events.dart';

class EventsRepo extends PostRepoBase {
  final postTable = EventsTable(); // Badly Coupled..

  @override
  Future<List<EventModel>> getData() async {
    final obj = await postTable.getRecords();
    List<EventModel> result = [];
    obj.forEach((item) {
      result.add(EventModel.fromMap(item));
    });
    return result;
  }

  @override
  Future<bool> insertData(EventModel post) async {
    postTable.insertRecord(post.toMap());
    return true;
  }

  @override
  Future<bool> deleteAllData() async {
    return postTable.deleteRecords();
  }
}
