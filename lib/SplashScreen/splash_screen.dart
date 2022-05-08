import 'dart:async';

import 'package:flutter/material.dart';

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
    Timer(const Duration(seconds: 2) ,(){ Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()));});
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Image.asset('assets/SplashLogo/todo.png',color: Colors.blue,scale: 25) ,
      ),
    );
  }
}
