import 'package:dzevent/data/repo/events/events_repo.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsCubit extends Cubit<EventsState> {
  final localRepo = EventsRepo();
  EventsCubit() : super(EventsInitial());

  Future<bool> getUserData() async {
    emit(EventsLoading());
    final response = await localRepo.getData();
    emit(EventsFetched(events: response));
    return true;
  }
}
