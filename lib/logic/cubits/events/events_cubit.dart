import 'package:dzevent/data/repo/history/post_repo_local.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsCubit extends Cubit<EventsState> {
  final localRepo = PostRepoLocal();
  EventsCubit() : super(EventsInitial());

  Future<bool> getUserData() async {
    emit(EventsLoading());
    final response = await localRepo.getData();
    emit(EventsFetched(posts: response));
    return true;
  }
}
