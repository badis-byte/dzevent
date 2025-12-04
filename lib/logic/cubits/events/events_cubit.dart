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

  Future<bool> insert(EventModel event) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.insertData(event);
      if (!response) {
        emit(AddNewEventFailure());
        return false;
      } else {
        emit(AddNewEventSuccess());
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
      emit(AddNewEventSuccess());
      return true;
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> deleteInstace(String id) async {
    try {
      emit(EventsLoading());
      final response = await localRepo.deleteRecord(id);
      // emit(DeleteEventSuccess());
      return true;
    } catch (e) {
      emit(EventsError(error: e.toString()));
      return false;
    }
  }
}
