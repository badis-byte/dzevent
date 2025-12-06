import 'package:dzevent/data/models/assoc_model.dart';
import 'package:flutter/cupertino.dart';

import '../../databases/db_association.dart';
import '../../databases/db_auth.dart';
import 'assoc_repo_base.dart';

class AssocRepoLocal extends AssocRepoBase {
  final associatoinTable = AssociationTable(); // Badly Coupled..
  final authTable = DBAuth();

  @override
  Future<List<AssociationModel>> getData() async {
    final obj = await associatoinTable.getRecords();
    List<AssociationModel> result = [];
    for (var item in obj) {
      result.add(AssociationModel.fromMap(item));
    }
    return result;
  }

  @override
  Future<bool> insertData(AssociationModel association) async {
    associatoinTable.insertRecord(association.toMap());
    return true;
  }

  @override
  Future<bool> deleteAllData() async {
    return associatoinTable.deleteRecords();
  }

  @override
  Future<AssociationModel> login(String email, String password) async {
    try {
      var association = await authTable.getAssociationByCredentials(
        email,
        password,
      );
      return association;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AssociationModel>> getUnverifiedUser() async {
    try {
      final obj = await associatoinTable.getAssociationUnv();
      print("size of object is ${obj.length}");
      List<AssociationModel> result = [];
      for (var item in obj) {
        result.add(item);
      }
      return result;
    } catch (e) {
      throw Exception("something went wrong");
    }
  }
}
