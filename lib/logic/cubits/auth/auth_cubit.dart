import 'package:dzevent/data/databases/db_auth.dart';
import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/data/repo/association/assoc_repo_local.dart';
import 'package:dzevent/data/repo/user/user_repo_local.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountGuest());
  final localAssRepo = AssocRepoLocal();
  final localUserRepo = UserRepoLocal();
  UserModel? currentUser;
  AssociationModel? currentAssociation;
  bool association = false;
  var authTable = DBAuth();

  Future<bool> login(String email, String password) async {
    try {
      emit(AccountLoading());
      currentUser = await localUserRepo.login(email, password);
      association = false;
      emit(UserFetched(user: currentUser!));
    } catch (e) {
      if (e is InvalidCredException) {
        try {
          currentAssociation = await localAssRepo.login(email, password);
          association = true;
          emit(AssociationFetched(association: currentAssociation!));
        } catch (a) {
          if (a is InvalidCredException) {
            emit(AccountError(error: "Invalid Credentials"));
          } else if (a is NotVerifiedException) {
            emit(AccountNotVerified());
          } else {
            emit(AccountError(error: "An error occured1"));
          }
        }
      } else {
        print(e);
        emit(AccountError(error: "An error occured2"));
      }
    }
    return true;
  }

  // UserModel? getCurrentUser() {
  //   return _currentUser;
  // }

  // AssociationModel? getCurrentAssociation() {
  //   if(state is AssociationFetched()){

  //   }

  // }

  Future<bool> register(
    String name,
    String email,
    String password,
    bool association,
  ) async {
    emit(AccountLoading());
    try {
      await authTable.checkUnique(email);
    } catch (e) {
      print("problem here");
      if (e is ExistingCredException) {
        emit(AccountExists());
        return true;
      } else {
        emit(AccountError(error: "cant connect to DB"));
      }
    }
    try {
      emit(AccountLoading());
      if (association) {
        AssociationModel assoc = AssociationModel(
          // id: 1,
          name: name,
          email: email,
          profilePicture: "assets/images/users/association.png",
          bio: "we're a new Associatoin to DZevent!",
          createdAt: DateTime.now(),
          isVerified: false,
        );
        var res = await localAssRepo.insertData(assoc);
        emit(AccountGuest());
        association = true;
        print("registered: ");
        print(res);
      } else {
        UserModel user = UserModel(
          // id: 1,
          name: name,
          email: email,
          profilePicture: "assets/images/users/guest.png",
          createdAt: DateTime.now(),
        );
        localUserRepo.insertData(user);
        emit(UserFetched(user: user));
        currentUser = user;
        association = false;
        print("registered: ");
        print(currentUser.toString());
      }
      return true;
    } catch (e) {
      emit(
        AccountError(
          error: "something weired happened.. Please try again later",
        ),
      );
      return true;
    }
  }

  Future<bool> getUserData() async {
    try {
      emit(AccountLoading());
      final response = await localUserRepo.getData();
      if (response.isEmpty) {
        emit(AccountGuest());
        return false;
      } else {
        emit(UserFetched(user: response[0]));
        return true;
      }
    } catch (e) {
      emit(AccountError(error: "Failed to get user data. Error: $e"));
      return false;
    }
  }

  Future<bool> getUnvAssoc() async {
    try {
      emit(AccountLoading());
      final response = await localAssRepo.getUnverifiedUser();
      if (response.isEmpty) {
        emit(AccountGuest());
        return false;
      } else {
        emit(AssociationsFetched(association: response));
        return true;
      }
    } catch (e) {
      emit(AccountError(error: "Failed to get user data. Error: $e"));
      return false;
    }
  }

  Future<bool> getAssoc(int id) async {
    try {
      emit(AccountLoading());
      final response = await localAssRepo.getAssociation(id);
      if (response.isEmpty) {
        AccountError(error: "empty data");
        return false;
      } else {
        emit(AssociationFetched(association: response.first));
        return true;
      }
    } catch (e) {
      emit(AccountError(error: "Failed to get user data. Error: $e"));
      return false;
    }
  }

  Future<bool> verifyAccount(int id) async {
    try {
      emit(AccountLoading());
      final response = await localAssRepo.verifyAssociation(id);
      emit(AccountUpdated());
      return response;
    } catch (e) {
      emit(AccountError(error: "unable to update association -> $e"));
      throw Exception("Something went wrong --> $e");
    }
  }

  Future<bool> deleteAccount(int id) async {
    try {
      emit(AccountLoading());
      final response = await localAssRepo.deleteAssociation(id);
      emit(AccountUpdated());
      return response;
    } catch (e) {
      emit(AccountError(error: "unable to delete association -> $e"));
      throw Exception("Something went wrong --> $e");
    }
  }
}
