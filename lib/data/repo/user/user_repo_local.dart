import 'package:dzevent/data/databases/db_auth.dart';
import 'package:dzevent/data/models/user_model.dart';

import '../../databases/db_user.dart';
import 'user_repo_base.dart';

class UserRepoLocal extends UserRepoBase {
  var authTable = DBAuth();
  var userTable = UserTable(); // Badly Coupled..

  @override
  Future<List<UserModel>> getData() async {
    final obj = await userTable.getRecords();
    List<UserModel> result = [];
    for (var item in obj) {
      result.add(UserModel.fromMap(item));
    }
    return result;
  }

  @override
  Future<bool> insertData(UserModel post) async {
    userTable.insertRecord(post.toMap());
    return true;
  }

  @override
  Future<bool> deleteAllData() async {
    return userTable.deleteRecords();
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      var user = await authTable.getUserByCredentials(email, password);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
