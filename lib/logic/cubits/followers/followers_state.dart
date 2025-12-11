abstract class FollowState {}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowError extends FollowState {
  final String message;
  FollowError(this.message);
}

class FollowListFetched extends FollowState {
  final List<int> followedAssociationIds;
  FollowListFetched(this.followedAssociationIds);
}

class FollowChanged extends FollowState {}
