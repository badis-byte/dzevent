import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/interest_model.dart';

sealed class InterestsState {}

class InterestsInitial extends InterestsState {}

class InterestsLoading extends InterestsState {}

class InterestsError extends InterestsState {
  final String error;
  InterestsError({required this.error});
}

sealed class InterestsCanToggle extends InterestsState {}

class InterestsFetched extends InterestsCanToggle {
  final List<InterestModel> interests;
  InterestsFetched({required this.interests});
}

class InterestsAssoUser extends InterestsState {
  final List<Map<String, dynamic>> result;
  InterestsAssoUser({required this.result});
}

class InterestedEventsFetched extends InterestsCanToggle {
  final List<EventModel> interestedEvents;
  InterestedEventsFetched({required this.interestedEvents});
}

// -- Mutations
class InterestsMutated extends InterestsState {}

class InterestAdded extends InterestsMutated {}

class InterestDeleted extends InterestsMutated {}
