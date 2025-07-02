import 'package:expenso_391/data/local/models/user_model.dart';
import 'package:expenso_391/data/local/repository/user_repo.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_event.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  UserRepository userRepo;
  UserBloc({required this.userRepo}) : super(UserInitialState()){

    on<RegisterUserEvent>((event, emit) async{

      emit(UserLoadingState());

      int result = await userRepo.registerUser(newUser: event.mUser);

      if(result==1){
        emit(UserSuccessState());
      } else if(result==2){
        emit(UserFailureState(errorMsg: "User email already exists"));
      } else if(result==3){
        emit(UserFailureState(errorMsg: "User MobNo already exists"));
      } else {
        emit(UserFailureState(errorMsg: "Error occurred while registering user"));
      }



    });

    on<AuthenticateUserEvent>((event, emit) async{
      emit(UserLoadingState());

      int result = await userRepo.authenticateUser(email: event.email, pass: event.pass);

      if(result==1){
        emit(UserSuccessState());
      } else if(result==2){
        emit(UserFailureState(errorMsg: "User email not found"));
      } else if(result==3){
        emit(UserFailureState(errorMsg: "Incorrect Password"));
      } else {
        emit(UserFailureState(errorMsg: "Error occurred while authenticating user.."));
      }

    });

    on<UserDetailEvent>((event, emit) async{
      emit(UserLoadingState());

     UserModel? data = await userRepo.getUserDetails();

     if(data!=null){
       emit(UserDetailsState(currentUser: data));
     } else {
       emit(UserFailureState(errorMsg: "Error occurred while getting user details"));
     }

    });

  }

}