import 'package:dzevent/data/databases/db_auth.dart';
import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/data/repo/association/assoc_repo_local.dart';
import 'package:dzevent/data/repo/user/user_repo_local.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState>{
  AccountCubit() : super(AccountGuest());
  final localAssRepo = AssocRepoLocal();
  final localUserRepo = UserRepoLocal();
  UserModel? _currentUser;
  AssociationModel? _currentAssociation;
  bool association = false;
  var authTable = DBAuth();


  Future<bool> login(String email, String password) async{
    try{
      emit(AccountLoading());
      _currentUser =  await localUserRepo.login(email, password);
      association = false;
      emit(UserFetched(user: _currentUser!));
    }catch(e){
      if(e is InvalidCredException){
        try{
          _currentAssociation =  await localAssRepo.login(email, password);
          association = true;
          emit(AssociationFetched(association: _currentAssociation!));
      }catch(e){
        if(e is InvalidCredException){
          emit(AccountError(error: "Invalid Credentials"));
        }
        else if(e is NotVerifiedException){
          emit(AccountNotVerified());
        }
        else{
          emit(AccountError(error: "An error occured"));
        }
        }
      }else{
        emit(AccountError(error: "An error occured"));
      }
    }
    return true;
  }


  Future<bool> register(String name, String email, String password, bool association)async{
    emit(AccountLoading());
    try{
      await authTable.checkUnique(email);
    }catch(e){
      emit(AccountExists());
      return true;
    }
    try{
      emit(AccountLoading());
      if(association){
        AssociationModel assoc = AssociationModel(id: 1, name: name, email: email, passwordHash: password, profilePicture: "", bio: "we're a new Associatoin to DZevent!", createdAt: DateTime.now(), verified: false);
        localAssRepo.insertData(assoc);
        emit(AssociationFetched(association: assoc));
        association=true;
      }else{
        UserModel user = UserModel(id: 1, name: name, email: email, passwordHash: password, profilePicture: "", bio: "I'm a new user to DZevent!", createdAt: DateTime.now());
        localUserRepo.insertData(user);
        emit(UserFetched(user: user));
        association= false;
      }
      return true;
    }catch(e){
      emit(AccountError(error: "something weired happened.. Please try again later")) ;
      return true;
    }

  }
  }