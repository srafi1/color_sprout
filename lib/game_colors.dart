import 'dart:ui';

import 'package:flutter/material.dart';

class GameColors {
  static Color background = Color(0xFFC8FBC8);
  static Color outline = Colors.black;
  static List<Color> tileColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Color(0xFFFBC02D),
    Colors.purple,
  ];
  static List<Color> targetColors = [
    Colors.blue.withOpacity(.6),
    Colors.red.withOpacity(.6),
    Colors.green.withOpacity(.6),
    Color(0xFFFBC02D).withOpacity(.6),
    Colors.purple.withOpacity(.6),
  ];
}
