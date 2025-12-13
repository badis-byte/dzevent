import 'package:dzevent/data/databases/db_auth.dart';
import 'package:dzevent/data/models/user_model.dart';

import '../../databases/db_user.dart';
import 'user_repo_base.dart';

class UserRepoLocal extends UserRepoBase {
  var authTable = DBAuth();
  var userTable = UserTable(); // Badly Coupled..

  @override
  Future<List<UserModel>> getData() async {
    final obj = await userTable.getAllRecords();
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

  @override
  Future<bool> update(UserModel value, int id)async{
    try{
      var state = await userTable.updateUser(value.toMap(), id);
      return state;
    }catch(e){
      rethrow;
    }

  }

  @override
  Future<UserModel> getUserById(int id) async {
    try {
      final obj = await authTable.getUserById(id);
      UserModel result = obj;
      return result;
    } catch (e) {
      throw Exception("something went wrong");
    }
  }
}
