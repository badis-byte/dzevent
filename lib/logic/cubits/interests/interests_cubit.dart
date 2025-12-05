import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/interest_model.dart';
import 'package:dzevent/data/repo/events/events_repo.dart';
import 'package:dzevent/data/repo/interests/interests_repo.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestsCubit extends Cubit<InterestsState> {
  final localRepo = InterestsRepo();
  InterestsCubit() : super(InterestsInitial());

  Future<bool> getUserInterests({required int userId}) async {
    try {
      emit(InterestsLoading());
      final response = await localRepo.getAllUserInterests(userId: userId);
      emit(InterestsFetched(interests: response));
      return true;
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> insert({required InterestModel interest}) async {
    try {
      emit(InterestsLoading());
      final response = await localRepo.createInterest(interest: interest);
      if (!response) {
        emit(InterestsError(error: "Failed to add the interest"));
        return false;
      } else {
        emit(InterestsAdded());
        emit(InterestsInitial());
        return true;
      }
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> delete({required int userId, required String eventId}) async {
    try {
      emit(InterestsLoading());
      final response = await localRepo.deleteInterest(
        userId: userId,
        eventId: eventId,
      );
      if (!response) {
        emit(InterestsError(error: "Failed to delete the interest"));
        return false;
      } else {
        emit(InterestsDeleted());
        emit(InterestsInitial());
        return true;
      }
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> toggle({required int userId, required String eventId}) async {
    final interest = await localRepo.getInterest(
      userId: userId,
      eventId: eventId,
    );
    if (interest == null) {
      // not found, create one
      return await insert(
        interest: InterestModel(
          userId: userId,
          eventId: eventId,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      return await delete(userId: userId, eventId: eventId);
    }
  }
}
