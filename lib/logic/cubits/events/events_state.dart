import 'package:dzevent/data/models/events_model.dart';

sealed class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsError extends EventsState {
  final String error;
  EventsError({required this.error});
}

class EventsFetched extends EventsState {
  final List<UserModel> events;
  EventsFetched({required this.events});
}
