import 'package:dzevent/data/models/user_model.dart';

import 'user_repo_local.dart';

abstract class UserRepoBase {
  Future<List<UserModel>> getData();
  Future<bool> insertData(UserModel value);
  Future<bool> deleteAllData();
  Future<UserModel> login(String email, String password);
  Future<UserModel> getUserById(int id);
  static UserRepoBase? _userInstance;

  static UserRepoBase getInstance() {
    _userInstance ??= UserRepoLocal();
    return _userInstance!; // For backend data
  }
}
