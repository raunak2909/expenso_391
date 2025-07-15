import 'package:expenso_391/ui/add_expense/add_expense_page.dart';
import 'package:expenso_391/ui/dashboard_page/dash_board_page.dart';
import 'package:expenso_391/ui/dashboard_page/provider/navigation_provider.dart';
import 'package:expenso_391/ui/home/home_page.dart';
import 'package:expenso_391/ui/intro/intro.dart';
import 'package:expenso_391/ui/sign_up/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/login/login_page.dart';
import '../../ui/splash/splash_page.dart';

class AppRoutes {
  static const String splash = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/home";
  static const String dashboard = "/dashboard";
  static const String intro = "/intro";
  static const String addExpense = "/add-exp";

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (_) => SplashPage(),
    intro: (_) => IntroPage(),
    login: (_) => LoginScreen(),
    signup: (_) => SignupScreen(),
    home: (_) => HomePage(),
    dashboard: (_) => ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: DashBoardPage(),
    ),
    addExpense: (_) => AddExpensePage(),
  };
}
