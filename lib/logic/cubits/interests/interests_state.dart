import 'package:dzevent/data/models/interest_model.dart';

sealed class InterestsState {}

class InterestsInitial extends InterestsState {}

class InterestsLoading extends InterestsState {}

class InterestsError extends InterestsState {
  final String error;
  InterestsError({required this.error});
}

class InterestsFetched extends InterestsState {
  final List<InterestModel> interests;
  InterestsFetched({required this.interests});
}

class InterestAdded extends InterestsState {}

class InterestDeleted extends InterestsState {}
