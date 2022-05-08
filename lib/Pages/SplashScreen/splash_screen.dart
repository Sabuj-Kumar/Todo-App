import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';

import '../HomePage/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3) ,(){ Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomePage()));});
    
    super.initState();
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
