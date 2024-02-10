import 'package:flutter/material.dart';
import 'package:invote/spalshservices/splashservice.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashservice = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservice.isLogin(context);
  }


  @override
  Widget build(BuildContext context) {



    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("images/applogo.jpg"),height: 300,),
            Text("I N V O T E",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),

            Text("For The People , By The People , Of The People",style: TextStyle(
              fontSize: 15
            ),),
          ],
        ),
      ),
    );
  }
}
