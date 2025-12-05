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
  UserModel? _currentUser;
  AssociationModel? _currentAssociation;
  bool association = false;
  var authTable = DBAuth();

  Future<bool> login(String email, String password) async {
    try {
      emit(AccountLoading());
      _currentUser = await localUserRepo.login(email, password);
      association = false;
      emit(UserFetched(user: _currentUser!));
    } catch (e) {
      if (e is InvalidCredException) {
        try {
          _currentAssociation = await localAssRepo.login(email, password);
          association = true;
          emit(AssociationFetched(association: _currentAssociation!));
        } catch (a) {
          if (a is InvalidCredException) {
            emit(AccountError(error: "Invalid Credentials"));
          } else if (e is NotVerifiedException) {
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
          id: 1,
          name: name,
          email: email,
          passwordHash: password,
          profilePicture: "/picAssociation",
          bio: "we're a new Associatoin to DZevent!",
          createdAt: DateTime.now(),
          verified: false,
        );
        localAssRepo.insertData(assoc);
        emit(AccountGuest());
        association = true;
        print("registered: ");
        print(_currentAssociation.toString());
      } else {
        UserModel user = UserModel(
          id: 1,
          name: name,
          email: email,
          passwordHash: password,
          profilePicture: "no image",
          createdAt: DateTime.now(),
        );
        localUserRepo.insertData(user);
        emit(UserFetched(user: user));
        _currentUser = user;
        association = false;
        print("registered: ");
        print(_currentUser.toString());
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
}
