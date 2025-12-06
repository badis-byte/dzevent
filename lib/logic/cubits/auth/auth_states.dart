import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/user_model.dart';

sealed class AccountState {}

class AccountGuest extends AccountState {}

class AccountLoading extends AccountState {}

class AccountExists extends AccountState {}

class AccountError extends AccountState {
  String error;
  AccountError({required this.error});
}

class AccountNotVerified extends AccountState {}

class AccountUpdated extends AccountState{}

class UserFetched extends AccountState {
  UserModel user;
  UserFetched({required this.user});
}

class AssociationFetched extends AccountState {
  AssociationModel association;
  AssociationFetched({required this.association});
}
class AssociationsFetched extends AccountState {
  final List<AssociationModel> association;

  AssociationsFetched({required this.association});
}


//if(state is AssociationFetched){
    // state.ass
// }