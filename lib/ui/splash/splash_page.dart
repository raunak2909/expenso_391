import 'dart:async';
import 'package:expenso_391/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_route/app_routes.dart';
import '../../utils/ui_helper/styles.dart';


class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt(AppConstants.PREF_USER_ID_KEY) ?? 0;

      bool isIntroLoaded = prefs.getBool(AppConstants.PREF_IS_INTRO_LOADED_KEY) ?? false;
      String nextPageName = AppRoutes.intro;

      if(isIntroLoaded){
        nextPageName = AppRoutes.login;
      }

      if(userId>0){
        nextPageName = AppRoutes.dashboard;
      }

      Navigator.pushReplacementNamed(context, nextPageName);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///FlutterLogo(size: 100,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withAlpha(50)
                ),
                  child: Image.asset("assets/icons/logo.png", width:200, height: 200, fit: BoxFit.cover)),
              SizedBox(height: 11,),
              Text("Expenso: Easy way to monitor your expenses", style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center,),
              SizedBox(height: 11,),
              Text("Stablize your future by taking care of your expenses now", style:  Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,),
              /*FloatingActionButton(
                  onPressed: (){},
                  tooltip: 'Next',
                  child: const Icon(Icons.arrow_forward),
              )*/



            ],
          ),
        ),
      ),
    );
  }
}
