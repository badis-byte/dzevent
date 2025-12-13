import 'package:dzevent/data/remoteRepo/followers/followers_repo_local.dart';
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
  try {
    emit(FollowLoading()); // optional: show loading
    await repository.follow(userId, assocId);
    final ids = await repository.getFollowedAssociations(userId);
    emit(FollowListFetched(ids));
  } catch (e) {
    emit(FollowError(e.toString()));
  }
}

Future<void> unfollow(int userId, int assocId) async {
  try {
    emit(FollowLoading()); // optional
    await repository.unfollow(userId, assocId);
    final ids = await repository.getFollowedAssociations(userId);
    emit(FollowListFetched(ids));
  } catch (e) {
    emit(FollowError(e.toString()));
  }
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


