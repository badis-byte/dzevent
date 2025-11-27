import 'history_repository.dart';

abstract class HistoryRepositoryBase {
  Future<List<String>> getData();
  Future<bool> insertData(String value);
  Future<bool> deleteAllData();

  static HistoryRepositoryBase? _historyInstance;

  static HistoryRepositoryBase getInstance() {
    _historyInstance ??= HistoryRepository();
    return _historyInstance!; // For backend data
  }
}
