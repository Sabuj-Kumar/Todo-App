import 'package:flutter/material.dart';
import 'package:mind_orbit_todo/AppBars/app_bars.dart';

import '../screen_heigt_with.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBars(title: "Todo List",titleColor: Colors.black87,bgColor: Colors.white),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: ElevatedButton(
            onPressed: (){},
            child: Text("Create New Todo",style: TextStyle(color: Colors.black87,fontSize: screenWidth * 0.025),),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                maximumSize: Size(screenWidth * 0.5,screenHeight * 0.05)
            ),
          )),
          Expanded(child: ElevatedButton(
            onPressed: (){},
            child: Text("Edit Profile",style: TextStyle(color: Colors.black87,fontSize: screenWidth * 0.025),),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              maximumSize: Size(screenWidth * 0.5,screenHeight * 0.05)
            ),
          )),
        ],
      )
    );
  }
}
