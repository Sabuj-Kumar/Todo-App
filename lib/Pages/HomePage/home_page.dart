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
    return SafeArea(
      child: Scaffold(
        appBar: AppBars(title: "Todo List",titleColor: Colors.black87,bgColor: Colors.white,context: context,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Create New Todo",style: TextStyle(color: Colors.black87,fontSize: HeightWidth(context).screenWidth * 0.05),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    maximumSize: Size(HeightWidth(context).screenWidth * 0.8,HeightWidth(context).screenHeight * 0.05)
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Edit Profile",style: TextStyle(color: Colors.white,fontSize: HeightWidth(context).screenWidth * 0.05),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  maximumSize: Size(HeightWidth(context).screenWidth * 0.8,HeightWidth(context).screenHeight * 0.05)
                ),
              ),
            ),
            SizedBox(height: HeightWidth(context).screenHeight * 0.1,)
          ],
        )
      ),
    );
  }
}
