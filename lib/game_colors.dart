import 'dart:ui';

import 'package:flutter/material.dart';

class GameColors {
  static Color background = Color(0xFFC8FBC8);
  static Color outline = Colors.black;
  static List<Color> tileColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
  ];
  static List<Color> targetColors = [
    Colors.blue.withOpacity(.8),
    Colors.red.withOpacity(.8),
    Colors.green.withOpacity(.8),
    Colors.purple.withOpacity(.8),
  ];
}
