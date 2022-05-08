import 'package:flutter/material.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';


class AppBars extends StatelessWidget with PreferredSizeWidget {
  const AppBars({Key? key,this.title, this.bgColor,this.titleColor,this.drawer,required this.context}) : super(key: key);
  final String? title;
  final Color? bgColor;
  final Color? titleColor;
  final Drawer? drawer;
  final BuildContext? context;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(HeightWidth(context!).screenHeight * 0.06);

  @override
  Widget build(BuildContext context) {
    final hieght = HeightWidth(context).screenHeight;
    //final width = HeightWidth(context).screenWidth;

    return AppBar(
      leading: drawer,
      title: Text(title!),
      titleTextStyle: TextStyle(color: titleColor,fontSize: (hieght * 0.025),
    ),
      backgroundColor: bgColor,
    centerTitle: true,
    );
  }

}
