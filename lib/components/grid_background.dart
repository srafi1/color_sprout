import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/cupertino.dart';

class GridBackground extends Component {
  Rect bgRect;
  Paint bgColor;

  Offset topLeft, topRight, bottomLeft, bottomRight;

  GridBackground() : bgColor = Paint()
                     ..color = GameColors.outline
                     ..strokeWidth = 5;

  @override
  void resize(Size newSize) {
    super.resize(newSize);
    double top = newSize.height/2 - newSize.width/2 - 5;
    bgRect = Rect.fromLTWH(0, top, newSize.width, newSize.width + 10);
    topLeft = Offset(0, top);
    topRight = Offset(newSize.width, top);
    bottomLeft = Offset(0, top + newSize.width + 10);
    bottomRight = Offset(newSize.width, top + newSize.width + 10);
  }

  @override
  void render(Canvas c) {
    c.drawLine(topLeft, topRight, bgColor);
    c.drawLine(bottomLeft, bottomRight, bgColor);
  }

  @override
  void update(double t) { }
}
