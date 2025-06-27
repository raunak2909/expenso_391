import 'package:expenso_391/data/local/helper/db_helper.dart';
import 'package:expenso_391/data/local/repository/user_repo.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) =>
          UserBloc(userRepo:
          UserRepository(dbHelper:
          DBHelper.getInstance())),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
