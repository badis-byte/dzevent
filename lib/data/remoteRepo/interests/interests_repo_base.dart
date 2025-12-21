import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/interest_model.dart';

import 'package:dzevent/data/remoteRepo/interests/interests_repo.dart';

abstract class InterestsRepoBase {
  Future<List<InterestModel>> getAllUserInterests({required int userId});
  Future<InterestModel?> getInterest({
    required int userId,
    required String eventId,
  });
  Future<List<EventModel>> getUserInterestedEvents({required int userId});

  // Future<List<InterestModel>> getEventInterests({required String eventId});

  Future<bool> createInterest({required InterestModel interest});
  Future<bool> deleteInterest({required int userId, required String eventId});
  Future<List<InterestModel>> getInterestAssociation({required int assoId});
  static InterestsRepoBase? _instance;

  static InterestsRepoBase getInstance() {
    _instance ??= InterestsRepo();
    return _instance!; // For backend data
  }
}
