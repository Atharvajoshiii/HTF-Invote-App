import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invote/auth/signin.dart';
import 'package:invote/auth/signup.dart';
import 'package:invote/screens/adddetail.dart';
import 'package:invote/screens/guidelinepage.dart';
import 'package:invote/screens/onboardingscreen.dart';
import 'package:invote/spalshservices/splashscreen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: SplashScreen(),
    );
  }
}
