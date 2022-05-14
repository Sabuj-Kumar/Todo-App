import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mind_orbit_todo/Pages/SignInAndSingUpPage/SignInPage/sign_in_page.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage/home_page.dart';
import '../NecessaryStrings/necessary_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 2),(){
      _checkToken();
    });
    super.initState();
  }
  _checkToken()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.containsKey(token)){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx) => const HomePage()));
    }
    else {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx) => const SignInPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: SizedBox(
            height: HeightWidth(context).screenHeight * 0.7,
            width: HeightWidth(context).screenWidth * 0.7,
            child: Image.asset('assets/todo.png',color: Colors.blue)),
      ),
    );
  }
}
