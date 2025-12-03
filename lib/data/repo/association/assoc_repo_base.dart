import 'package:dzevent/data/models/assoc_model.dart';

import 'assoc_repo_local.dart';

abstract class AssocRepoBase {
  Future<List<AssociationModel>> getData();
  Future<bool> insertData(AssociationModel value);
  Future<bool> deleteAllData();
  Future<AssociationModel> login(String email, String password);

  static AssocRepoBase? _assocInstance;

  static AssocRepoBase getInstance() {
    _assocInstance ??= AssocRepoLocal();
    return _assocInstance!; // For backend data
  }
}
