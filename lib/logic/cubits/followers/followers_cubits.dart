import 'package:dzevent/data/repo/followers/followers_repo_local.dart';
import 'package:dzevent/logic/cubits/followers/followers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowCubit extends Cubit<FollowState> {
  final repository= FollowersRepoLocal();

  FollowCubit() : super(FollowInitial());

  Future<void> getFollowedAssociations(int userId) async {
    emit(FollowLoading());
    try {
      final ids = await repository.getFollowedAssociations(userId);
      emit(FollowListFetched(ids));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }

  Future<void> follow(int userId, int assocId) async {
    await repository.follow(userId, assocId);
    emit(FollowChanged());
    await getFollowedAssociations(userId);
  }

  Future<void> unfollow(int userId, int assocId) async {
    await repository.unfollow(userId, assocId);
    emit(FollowChanged());
    await getFollowedAssociations(userId);
  }


  Future<int> getFollowers(int assocId) async{
  try{
    final score = repository.getFollowers(assocId);
    return score;
  }catch(e){
    rethrow;
  }
}

}


