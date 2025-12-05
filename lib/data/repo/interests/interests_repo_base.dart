import 'package:dzevent/data/models/interest_model.dart';

import 'interests_repo.dart';

abstract class InterestRepoBase {
  Future<List<InterestModel>> getAllUserInterests({required int userId});
  // Future<List<InterestModel>> getEventInterests({required String eventId});

  Future<bool> createInterest({required InterestModel interest});
  Future<bool> deleteInterest({required int userId, required String eventId});

  static InterestRepoBase? _instance;

  static InterestRepoBase getInstance() {
    _instance ??= InterestsRepo();
    return _instance!; // For backend data
  }
}
