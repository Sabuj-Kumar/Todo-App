import 'package:flutter/material.dart';


class AppBars extends StatelessWidget with PreferredSizeWidget {
  const AppBars({Key? key,this.title, this.bgColor,this.titleColor}) : super(key: key);
  final String? title;
  final Color? bgColor;
  final Color? titleColor;
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(75);
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return AppBar(
      title: Text(title!),
      titleTextStyle: TextStyle(color: titleColor,fontSize: (hieght),
      backgroundColor: bgColor,
    ));
  }

}
