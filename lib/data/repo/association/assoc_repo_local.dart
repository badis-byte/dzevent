import 'package:dzevent/data/models/assoc_model.dart';

import '../../databases/db_association.dart';
import '../../databases/db_auth.dart';
import 'assoc_repo_base.dart';

class AssocRepoLocal extends AssocRepoBase {
  final AssociationTable associatoinTable;
  final DBAuth authTable;

  AssocRepoLocal({
    AssociationTable? associatoinTable,
    DBAuth? authTable,
  })  : associatoinTable = associatoinTable ?? AssociationTable(),
        authTable = authTable ?? DBAuth();

  @override
  Future<List<AssociationModel>> getData() async {
    final obj = await associatoinTable.getAllRecords();
    return obj.map((e) => AssociationModel.fromMap(e)).toList();
  }

  @override
  Future<bool> insertData(AssociationModel association) async {
    return associatoinTable.insertRecord(association.toMap());
  }

  @override
  Future<bool> deleteAllData() async {
    return associatoinTable.deleteRecords();
  }

  @override
  Future<AssociationModel> login(String email, String password) async {
    return authTable.getAssociationByCredentials(email, password);
  }

  @override
  Future<List<AssociationModel>> getUnverifiedUser() async {
    return associatoinTable.getAssociationUnv();
  }

  @override
  Future<List<AssociationModel>> getAssociation(int id) async {
    return associatoinTable.getAssociation(id);
  }

  @override
  Future<bool> verifyAssociation(int id) async {
    await associatoinTable.verifyAssociation(id);
    return true;
  }

  @override
  Future<bool> deleteAssociation(int id) async {
    await associatoinTable.deleteAssociation(id);
    return true;
  }
}
