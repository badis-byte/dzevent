
import 'followers_repo_local.dart';

abstract class FollowersRepoBase {
  Future<int> getFollowers(int assocId);
  Future<bool> unfollow(int userId ,int assocId);
  Future<List<int>> getFollowedAssociations(int userId);
  Future<bool> follow(int usetId, int assocId);

  static FollowersRepoBase? _userInstance;

  static FollowersRepoBase getInstance() {
    _userInstance ??= FollowersRepoLocal();
    return _userInstance!; // For backend data
  }
}
