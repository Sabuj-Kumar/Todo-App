import 'package:flutter/material.dart';
class HeightWidth {
  BuildContext context;

  HeightWidth(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
}