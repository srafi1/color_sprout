import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class GridBackground extends Component {
  Rect? bgRect ;
  Paint bgColor = Paint()
    ..color = GameColors.outline
    ..strokeWidth = 5;

  Offset? topLeft, topRight, bottomLeft, bottomRight;

  GridBackground() {}

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    double top = newSize.y/2 - newSize.x/2 - 5;
    bgRect = Rect.fromLTWH(0, top, newSize.x, newSize.x + 10);
    topLeft = Offset(0, top);
    topRight = Offset(newSize.x, top);
    bottomLeft = Offset(0, top + newSize.x + 10);
    bottomRight = Offset(newSize.x, top + newSize.x + 10);
  }

  @override
  void render(Canvas c) {
    c.drawLine(topLeft!, topRight!, bgColor);
    c.drawLine(bottomLeft!, bottomRight!, bgColor);
  }

  @override
  void update(double t) { }
}
