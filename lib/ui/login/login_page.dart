
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:flutter/material.dart';
import '../../utils/ui_helper/styles.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, AppRoutes.home);
                        },
                        style: buttonStyle,
                        child: Text('Login')
                    ),
                    SizedBox(height: 11,),
                    TextButton(onPressed: (){
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
