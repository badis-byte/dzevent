import 'package:dzevent/data/models/events_model.dart';

import '../../databases/db_events.dart';
import 'post_repo_base.dart';

class PostRepoLocal extends PostRepoBase {
  final postTable = PostsTable(); // Badly Coupled..

  @override
  Future<List<UserModel>> getData() async {
    final obj = await postTable.getRecords();
    List<UserModel> result = [];
    obj.forEach((item) {
      result.add(UserModel.fromMap(item));
    });
    return result;
  }

  @override
  Future<bool> insertData(UserModel post) async {
    postTable.insertRecord(post.toMap());
    return true;
  }

  @override
  Future<bool> deleteAllData() async {
    return postTable.deleteRecords();
  }
}
