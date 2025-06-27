import 'package:expenso_391/data/local/models/user_model.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_event.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:expenso_391/utils/ui_helper/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_route/app_routes.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/expenso_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withValues(alpha: 0.7)),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt_1, size: 40, color: Colors.white),
                    SizedBox(height: 11),
                    Text('Create Account', style: login_headingStyle),
                    SizedBox(height: 11),
                    TextField(
                      controller: nameController,
                      style: TextStyle(color: Colors.black45),
                      decoration: inputDecoration('Name'),
                    ),
                    SizedBox(height: 11),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black45),
                      decoration: inputDecoration('Email'),
                    ),
                    SizedBox(height: 11),
                    TextField(
                      controller: mobNoController,
                      style: TextStyle(color: Colors.black45),
                      decoration: inputDecoration('MobNo'),
                    ),
                    SizedBox(height: 11),
                    TextField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.black45),
                      decoration: inputDecoration('Password'),
                    ),
                    SizedBox(height: 11),
                    BlocConsumer<UserBloc, UserState>(
                      listener: (_, state){

                        if(state is UserLoadingState){
                          isLoading = true;
                        }

                        if(state is UserSuccessState){
                          isLoading = false;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Registered Successfully!!"), backgroundColor: Colors.green,));
                        }

                        if(state is UserFailureState){
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errorMsg}"), backgroundColor: Colors.red,));
                        }

                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            UserModel user = UserModel(
                              name: nameController.text,
                              email: emailController.text,
                              mobNo: mobNoController.text,
                              pass: passwordController.text,
                            );

                            context.read<UserBloc>().add(
                              RegisterUserEvent(mUser: user),
                            );
                          },
                          child: isLoading ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 10),
                              Text('Signing Up...')
                            ],
                          ) : Text('Sign Up'),
                        );
                      }
                    ),
                    SizedBox(height: 11),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        //Navigator.pushReplacementNamed(context, AppRoutes.home);
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
