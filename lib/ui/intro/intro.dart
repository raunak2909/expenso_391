import 'package:expenso_391/ui/login/login_page.dart';
import 'package:expenso_391/utils/app_route/app_routes.dart';
import 'package:expenso_391/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_page.dart';

class IntroPage extends StatefulWidget{
  @override
  State<IntroPage> createState() => _IntroState();
}

class _IntroState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [Column(
            children: [
              SizedBox(height: 140,),
              Image.asset("assets/icons/logo.png",width: 500,),
              Text("Save your money with Expense Tracker",textAlign: TextAlign.center,style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text("Save money! The more your money works for you, the less you have to work for money.",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
                ),),
              )
            ],
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 70),
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.pink.shade300,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(22, 16), // X-radius, Y-radius
                  ),
                ),
                child: InkWell(
                  onTap: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool(AppConstants.PREF_IS_INTRO_LOADED_KEY, true);

                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: Text("Let's Start",style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),),
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}