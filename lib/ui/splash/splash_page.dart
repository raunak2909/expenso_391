import 'dart:async';
import 'package:flutter/material.dart';

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
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, AppRoutes.intro);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///FlutterLogo(size: 100,),
              Image.asset("assets/icons/logo.png", width:200, height: 200, fit: BoxFit.cover),
              SizedBox(height: 11,),
              Text("Expenso: Easy way to monitor your expenses", style: logoStyle,),
              SizedBox(height: 11,),
              Text("Stablize your future by taking care of your expenses now", style:  logosubStyle,),
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
