import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/user_model.dart';

import 'dbhelper.dart';

class InvalidCredException implements Exception {}

class ExistingCredException implements Exception {}

class NotVerifiedException implements Exception {}

class DBAuth {
  Future<AssociationModel> getAssociationByCredentials(
    String email,
    String password,
  ) async {
    final db = await DBHelper.getDatabase();

try{
    final result = await db.query(
      'associations',
      where: 'email = ?',
      whereArgs: [email],
    );


    if (result.isNotEmpty) {
      var association = AssociationModel.fromMap(result.first);
      if (association.isVerified == true) {
        return association;
      }
      throw NotVerifiedException();
    }

    throw InvalidCredException();
    }catch(e){
  print(e);
  rethrow;
}
  }

  Future<UserModel> getUserByCredentials(String email, String password) async {
    final db = await DBHelper.getDatabase();

    final result = await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      try {
        var user = UserModel.fromMap(result.first);
        return user;
      } catch (e) {
        print(e);
        rethrow;
      }
    } else {
      throw InvalidCredException();
    }
  }

  Future<bool> checkUnique(String email) async {
    final db = await DBHelper.getDatabase();

    final result1 = await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result1.isNotEmpty) {
      throw ExistingCredException();
    }

    final result2 = await db.query(
      'associations',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result2.isNotEmpty) {
      throw ExistingCredException();
    }

    return true;
  }
}
