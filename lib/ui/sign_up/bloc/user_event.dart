import 'package:expenso_391/data/local/models/user_model.dart';

abstract class UserEvent{}

class RegisterUserEvent extends UserEvent{
  UserModel mUser;
  RegisterUserEvent({required this.mUser});
}

class AuthenticateUserEvent extends UserEvent{
  String email, pass;
  AuthenticateUserEvent({required this.email, required this.pass});
}