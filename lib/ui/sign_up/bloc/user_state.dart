import '../../../data/local/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {}
class UserDetailsState extends UserState {
  UserModel currentUser;
  UserDetailsState({required this.currentUser});
}

class UserFailureState extends UserState {
  String errorMsg;

  UserFailureState({required this.errorMsg});
}
