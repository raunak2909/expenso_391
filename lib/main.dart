import 'package:expenso_391/data/local/helper/db_helper.dart';
import 'package:expenso_391/data/local/repository/expense_repo.dart';
import 'package:expenso_391/data/local/repository/user_repo.dart';
import 'package:expenso_391/ui/bloc/expense_bloc.dart';
import 'package:expenso_391/ui/sign_up/bloc/user_bloc.dart';
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            userRepo: UserRepository(dbHelper: DBHelper.getInstance()),
          ),
        ),
        BlocProvider(
          create: (context) => ExpenseBloc(
            expRepo: ExpenseRepository(dbHelper: DBHelper.getInstance()),
          ),
        ),
      ],
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
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 21,
          ),
          bodyMedium: TextStyle(
            fontSize: 19,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
          ),
          labelLarge: TextStyle(
            fontSize: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom()
        ),
        cardTheme: CardThemeData(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
              side: BorderSide(
                color: Colors.black12,
                width: 2,
              ),
            )
        ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 21,
          ),
          bodyMedium: TextStyle(
            fontSize: 19,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
          ),
          labelLarge: TextStyle(
            fontSize: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom()
        ),
        cardTheme: CardThemeData(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
            side: BorderSide(
              color: Colors.black12,
              width: 2,
            ),
          )
        ),
        /*outlinedButtonTheme: ,
        textButtonTheme: ,
        inputDecorationTheme: ,
        cardTheme: ,*/
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
