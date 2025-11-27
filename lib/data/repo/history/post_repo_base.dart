import 'package:dzevent/data/models/events_model.dart';

import 'post_repo_local.dart';

abstract class PostRepoBase {
  Future<List<EventsModel>> getData();
  Future<bool> insertData(EventsModel value);
  Future<bool> deleteAllData();

  static PostRepoBase? _historyInstance;

  static PostRepoBase getInstance() {
    _historyInstance ??= PostRepoLocal();
    return _historyInstance!; // For backend data
  }
}
