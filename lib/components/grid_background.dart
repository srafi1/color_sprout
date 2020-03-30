import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/cupertino.dart';

class GridBackground extends Component {
  Rect bgRect;
  Paint bgColor;

  GridBackground() : bgColor = Paint()..color = GameColors.outline;

  @override
  void resize(Size newSize) {
    super.resize(newSize);
    double top = newSize.height/2 - newSize.width/2 - 5;
    bgRect = Rect.fromLTWH(0, top, newSize.width, newSize.width + 10);
  }

  @override
  void render(Canvas c) {
    c.drawRect(bgRect, bgColor);
  }

  @override
  void update(double t) { }
}
