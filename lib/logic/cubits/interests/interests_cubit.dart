import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/interest_model.dart';
import 'package:dzevent/data/remoteRepo/interests/interests_repo.dart';
import 'package:dzevent/data/remoteRepo/interests/interests_repo_base.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/interests/interests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestsCubit extends Cubit<InterestsState> {
  final InterestsRepoBase localRepo = InterestsRepo();
  InterestsCubit() : super(InterestsInitial());

  final List<InterestsState> _stateStack = [InterestsInitial()];

  bool enterTmpAction() {
    _stateStack.add(state);
    return true;
  }

  bool leaveTmpAction() {
    emit(_stateStack.removeLast());
    return true;
  }

  Future<bool> getUserInterests({required int userId}) async {
    try {
      emit(InterestsLoading());
      final response = await localRepo.getAllUserInterests(userId: userId);
      emit(InterestsFetched(interests: response));
      print("we got it");
      return true;
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      print("$e");
      return false;
    }
  }

  Future<bool> getAssoUserInterest(int assoId) async {
    try {
      emit(InterestsLoading());
      final interestAssoUsers = await localRepo.getInterestAssociation(
        assoId: assoId,
      );
      emit(InterestsFetched(interests: interestAssoUsers));
      //can i invoke a fuunction here using event and user cubit
      final AccountCubit userCubit = AccountCubit();
      final EventsCubit eventCubit = EventsCubit();
      //then ill use its functions
      List<Map<String, dynamic>> result = [];
      for (var intr in interestAssoUsers) {
        var user = await userCubit.getUser(intr.userId);
        var event = await eventCubit.getEvent(id: intr.eventId);
        if (event is EventModel) {
          final entery = <String, dynamic>{"user": user, "event": event};
          result.add(entery);
        }
      }
      emit(InterestsAssoUser(result: result));
      return true;
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      return false;
    }
  }

  Future<bool> getUserInterestedEvents({required int userId}) async {
    try {
      emit(InterestsLoading());
      final interestedEvents = await localRepo.getUserInterestedEvents(
        userId: userId,
      );
      emit(InterestedEventsFetched(interestedEvents: interestedEvents));
      return true;
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      print("$e");
      return false;
    }
  }

  Future<bool> insert({required InterestModel interest}) async {
    bool returnResult;
    enterTmpAction();

    try {
      emit(InterestsLoading());
      final response = await localRepo.createInterest(interest: interest);
      if (!response) {
        emit(InterestsError(error: "Failed to add the interest"));
        returnResult = false;
      } else {
        emit(InterestAdded());
        emit(InterestsInitial());
        returnResult = true;
      }
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      returnResult = false;
    }
    leaveTmpAction();
    return returnResult;
  }

  Future<bool> delete({required int userId, required String eventId}) async {
    bool returnResult;
    enterTmpAction();

    try {
      emit(InterestsLoading());
      final response = await localRepo.deleteInterest(
        userId: userId,
        eventId: eventId,
      );
      if (!response) {
        emit(InterestsError(error: "Failed to delete the interest"));
        returnResult = false;
      } else {
        emit(InterestDeleted());
        emit(InterestsInitial());
        returnResult = true;
      }
    } catch (e) {
      emit(InterestsError(error: e.toString()));
      returnResult = false;
    }
    leaveTmpAction();
    return returnResult;
  }

  Future<bool> toggle({required int userId, required String eventId}) async {
    /// Just a switch
    /// enterTmpAction and leaveTmpAction are done in both paths
    final interest = await localRepo.getInterest(
      userId: userId,
      eventId: eventId,
    );
    bool isToggled;
    if (interest == null) {
      // not found, create one
      isToggled = await insert(
        interest: InterestModel(
          userId: userId,
          eventId: eventId,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      isToggled = await delete(userId: userId, eventId: eventId);
    }
    return isToggled;
  }
}
