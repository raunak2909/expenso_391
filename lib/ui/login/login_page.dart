
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:flutter/material.dart';
import '../../utils/ui_helper/styles.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Back!", style: headingStyle),
            SizedBox(height: 20),
            TextField(decoration: inputDecoration("Email")),
            SizedBox(height: 10),
            TextField(decoration: inputDecoration("Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
