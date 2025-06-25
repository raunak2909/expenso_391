
import 'package:expenso_391/ui/home/home_page.dart';
import 'package:expenso_391/ui/intro/intro.dart';
import 'package:flutter/material.dart';

import '../../ui/login/login_page.dart';
import '../../ui/splash/splash_page.dart';

class AppRoutes {
  static const String splash = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/home";
  static const String intro = "/intro";

  static Map<String, Widget Function(BuildContext) > routes = {
    splash: (_) => SplashPage(),
    intro: (_) => IntroPage(),
    login: (_) => LoginScreen(),
    home: (_) => HomePage(),

  };
}