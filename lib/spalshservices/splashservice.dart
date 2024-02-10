import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invote/screens/guidelinepage.dart';
import 'package:invote/screens/onboardingscreen.dart';


class SplashService{
  void isLogin(BuildContext context){
    Timer(Duration(seconds:3),(){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ShoeAppOnboardingPage()) );
    });



  }
}