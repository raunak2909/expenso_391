
import 'package:expenso_391/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_event.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_state.dart';
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/ui_helper/styles.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool check = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/expenso_background.jpg',
                fit: BoxFit.cover,)
          ),
          Positioned.fill(
              child: Container(color: Colors.white.withValues(alpha: 0.7),)
          ),

          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 50, color: Colors.black,),
                    SizedBox(height: 11,),
                    Text('Welcome Back', style: headingStyle,),
                    SizedBox(height: 11,),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.grey),
                      decoration:inputDecoration('Email'),
                    ),
                    SizedBox(height: 11,),
                    TextField(
                      controller:  passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.grey),
                      decoration: inputDecoration('Password'),
                    ),
                    SizedBox(height: 11,),
                    BlocConsumer<UserBloc, UserState>(
                      listenWhen: (ps,cs){
                        return check;
                      },
                      listener: (_, state){

                        if(state is UserLoadingState){
                          isLoading = true;
                        }

                        if(state is UserSuccessState){
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully logged in")));
                          Navigator.pushReplacementNamed(context, AppRoutes.home);
                        }

                        if(state is UserFailureState){
                          isLoading = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                        }

                      },
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: (){
                              check = true;
                              //Navigator.pushReplacementNamed(context, AppRoutes.home);
                              context.read<UserBloc>().add(AuthenticateUserEvent(email: emailController.text, pass: passwordController.text));
                            },
                            style: buttonStyle,
                            child: isLoading ? Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 11,
                                ),
                                Text('Logging in...')
                              ],
                            ) : Text('Login')
                        );
                      }
                    ),
                    SizedBox(height: 11,),
                    TextButton(onPressed: (){
                      check = false;
                      Navigator.pushNamed(context, AppRoutes.signup);
                    }, child: Text("Don't have an account? Sign up",
                      style: TextStyle(color: Colors.black87),))
                  ],

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
