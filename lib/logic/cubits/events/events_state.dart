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

class SingleEventFetched extends EventsState {
  final EventModel event;
  SingleEventFetched({required this.event});
}

class AddNewEventSuccess extends EventsState {}

class UpdateEventSuccess extends EventsState {}

class DeleteEventSuccess extends EventsState {}
