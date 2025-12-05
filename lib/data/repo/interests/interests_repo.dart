import 'package:dzevent/data/databases/interests_table.dart';
import 'package:dzevent/data/models/interest_model.dart';
import 'package:dzevent/data/repo/interests/interests_repo_base.dart';

class InterestsRepo extends InterestRepoBase {
  final table = InterestsTable();

  @override
  Future<bool> createInterest({required InterestModel interest}) async {
    final isInserted = await table.insertRecord(interest.toMap());
    return isInserted;
  }

  @override
  Future<bool> deleteInterest({
    required int userId,
    required String eventId,
  }) async {
    final isDeleted = await table.deleteInterest(userId, eventId);
    return isDeleted;
  }

  // @override
  // Future<List<InterestModel>> getEventInterests({required String eventId}) {
  //   throw UnimplementedError();
  // }

  @override
  Future<List<InterestModel>> getUserInterests({required int userId}) async {
    final records = await table.getUserInterests(userId: userId);
    return records.map((record) => InterestModel.fromMap(record)).toList();
  }
}
