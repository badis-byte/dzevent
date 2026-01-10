import 'package:dzevent/data/databases/db_followers.dart';

import 'followers_repo_base.dart';

class FollowersRepoLocal extends FollowersRepoBase {
  var followersTable = FollowersTable(); // Badly Coupled..

  @override
  Future<int> getFollowers(int assocId) async{
    try{
      final score = await followersTable.getFollowers(assocId);
      return score;
    }catch(e){
      rethrow;
    }
  }
  @override
  Future<bool> unfollow(int userId, int assocId)async{
    try{
      final score = await followersTable.unfollow(userId, assocId);
      return score;
    }catch(e){
      rethrow;
    }

  }
  @override
  Future<List<int>> getFollowedAssociations(int userId)async{
    try{
      final score = await followersTable.getFollowedAssociations(userId);
      return score;
    }catch(e){
      rethrow;
    }
  }
  @override
  Future<bool> follow(int userId, int assocId)async{
    try{
      final score = await followersTable.follow(userId, assocId);
      return score;
    }catch(e){
      rethrow;
    }
  }

  
}
