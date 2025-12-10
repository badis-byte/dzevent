import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/repo/events/events_repo.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsCubit extends Cubit<EventsState> {
  final localRepo = EventsRepo();
  EventsCubit() : super(EventsInitial());

  Future<bool> getAll() async {
    try {
      emit(EventsLoading());
      final response = await localRepo.getData();
      emit(EventsFetched(events: response));
      return true;
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> getEvent({required String id}) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.getEvent(id: id);
      if (response == null) {
        emit(EventsError(error: "(getEvent) event #$id not found"));
        return false;
      } else {
        emit(SingleEventFetched(event: response));
        return true;
      }
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> getEventByType({required String filter}) async {
    try {
      emit(EventsLoading());
      final List<EventModel> response = await localRepo.getEventByFilter(
        filter: filter,
      );
      if (response == []) {
        emit(EventsError(error: "(getEvent) event #$filter not found"));
        return false;
      } else {
        print("response <inside event cubit>: ${response.toString()}");
        emit(EventsFetched(events: response));
        return true;
      }
    } catch (e) {
      print("error ${e.toString()}");
      emit(EventsError(error: "no event found"));
      return false;
    }
  }

  Future<bool> getAllEventsByUser(int userId) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.getUserEvents(userId);
      emit(EventsFetched(events: response));
      return true;
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> insert(EventModel event) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.insertData(event);
      if (!response) {
        emit(EventsError(error: "Failed to add the event"));
        return false;
      } else {
        emit(AddNewEventSuccess());
        emit(EventsInitial());
        return true;
      }
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> update(EventModel event) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.updateRecord(event, event.id);
      if (!response) {
        emit(EventsError(error: "Failed to update the event"));
        return false;
      } else {
        emit(UpdateEventSuccess());
        emit(EventsInitial());
        return true;
      }
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> deleteInstace(String id) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.deleteRecord(id);
      if (!response) {
        emit(EventsError(error: "Failed to delete the event"));
        return false;
      } else {
        emit(DeleteEventSuccess());
        emit(EventsInitial());
        return true;
      }
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }
}
