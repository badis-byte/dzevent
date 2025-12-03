import 'package:dzevent/data/models/event_model.dart';

sealed class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsError extends EventsState {
  final String error;
  EventsError({required this.error});
}

class EventsFetched extends EventsState {
  final List<EventModel> events;
  EventsFetched({required this.events});
}

class AddNewEventSuccess extends EventsState {}

class AddNewEventFailure extends EventsState {}
