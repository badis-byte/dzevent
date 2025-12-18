import 'package:dzevent/data/databases/db_auth.dart';
import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/data/remoteRepo/association/assoc_repo_local.dart';
import 'package:dzevent/data/remoteRepo/user/user_repo_local.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/followers/followers_cubits.dart';
import 'package:dzevent/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountGuest());
  final localAssRepo = AssocRepoLocal();
  final localUserRepo = UserRepoSupa();
  UserModel? currentUser;
  AssociationModel? currentAssociation;
  bool association = false;
  var authTable = DBAuth();

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      emit(AccountLoading());
      currentUser = await localUserRepo.login(email, password);
      association = false;
      emit(UserFetched(user: currentUser!));

      final fcmtoken = await getFcmtoken();
      if (fcmtoken != null) {
        localUserRepo.setFcmtoken(userId: currentUser!.id!, fcmtoken: fcmtoken);
      } else {
        print("Failed to fetch fcmtoken");
      }

      await prefs.setBool("isAssoc", false);
      await prefs.setInt("id", currentUser!.id!);

    } catch (e) {
      if (e is InvalidCredException) {
        try {
          currentAssociation = await localAssRepo.login(email, password);
          print("current association is ${currentAssociation!.name}");
          association = true;
          emit(AssociationFetched(association: currentAssociation!));
          await prefs.setBool("isAssoc", true);
          await prefs.setInt("id", currentAssociation!.id!);
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

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('isAssoc');
    emit(AccountGuest());
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
          //id: 1,
          name: name,
          email: email,
          password: password,
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
          //id: 1,
          name: name,
          email: email,
          password: password,
          profilePicture: "assets/images/users/guest.png",
          createdAt: DateTime.now(),
        );
        var gottenuser = await localUserRepo.insertData(user);

        emit(UserFetched(user: gottenuser));
        currentUser = gottenuser;
        association = false;

        await prefs.setBool("isAssoc", false);
        await prefs.setInt("id", currentUser!.id!);
        print("registered: ");
        print(currentUser.toString());
      }
      return true;
    } catch (e) {
      emit(AccountError(error: "$e"));
      return true;
    }
  }

  Future<bool> getUserData() async {
    try {
      emit(AccountLoading());
      final response = await localUserRepo.getData();
      if (response.isEmpty) {
        emit(AccountGuest());
        currentUser = null; // Clear current user
        return false;
      } else {
        currentUser = response[0]; // SET THIS!
        association = false; // SET THIS TOO!
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
      print('$e');
      return false;
    }
  }

  Future<bool> getAssoc(int id) async {
    try {
      print("fetching association by id");
      emit(AccountLoading());
      final response = await localAssRepo.getAssociation(id);
      if (response.isEmpty) {
        AccountError(error: "empty data");
        return false;
      } else {
        emit(AssoicationDetailFetched(asso: response.first));
        return true;
      }
    } catch (e) {
      emit(AccountError(error: "Failed to get user data. Error: $e"));
      return false;
    }
  }

  Future<AssociationModel> getAssocInstance(int id) async {
    try {
      print("fetching association by id");
      emit(AccountLoading());
      final response = await localAssRepo.getAssociation(id);
      if (response.isEmpty) {
        AccountError(error: "empty data");
        return AssociationModel(
          name: "",
          email: "",
          password: "",
          profilePicture: "",
          bio: "",
          createdAt: DateTime.now(),
          isVerified: true,
        );
      } else {
        emit(AssoicationDetailFetched(asso: response.first));
        return response.first;
      }
    } catch (e) {
      emit(AccountError(error: "Failed to get user data. Error: $e"));
      return AssociationModel(
        name: "",
        email: "",
        password: "",
        profilePicture: "",
        bio: "",
        createdAt: DateTime.now(),
        isVerified: true,
      );
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

  Future<dynamic> getcurrentAssociation(int id) async {
    try {
      var response = await localAssRepo.getAssociation(id);

      print("response is : ${response.first}");

      currentAssociation = response.first; // SET THIS!
      association = true; // SET THIS TOO!
      emit(AssociationFetched(association: response.first));
      print("fetching association");
      return true;
    } catch (e) {
      print("error -> $e");
    }
  }

  Future<dynamic> getcurrentUser(int id) async {
    try {
      var response = await localUserRepo.getUserById(id);
      currentUser = response; // SET THIS!
      association = false; // SET THIS TOO!
      emit(UserFetched(user: response));
      print("fetching user");
      return true;
    } catch (e) {
      print("error -> $e");
    }

  }
  Future<UserModel?> getUser(int id) async {
    try {
      var response = await localUserRepo.getUserById(id);
      currentUser = response; // SET THIS!
      association = false; // SET THIS TOO!
      emit(UserFetched(user: response));
      print("fetching user");
      return currentUser;
    } catch (e) {
      print("error -> $e");
    }
  }

  Future<AssociationModel> getFollowedAssociation(int id) async {
    try {
      var response = await localAssRepo.getAssociation(id);
      return response[0];
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> update(UserModel user, int id) async {
    try {
      var response = await localUserRepo.update(user, id);
      emit(UserFetched(user: user));
      return response;
    } catch (e) {
      print("error -> $e");
      return true;
    }
  }

  bool setUser(UserModel user) {
    currentUser = user;
    return true;
  }
}
