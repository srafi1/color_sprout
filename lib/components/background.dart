import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/cupertino.dart';

class BackgroundComponent extends Component {
  Rect bgRect;
  Paint bgColor;

  BackgroundComponent() : bgColor = Paint()..color = GameColors.background;

  @override
  void resize(Size newSize) {
    super.resize(newSize);
    bgRect = Rect.fromLTWH(0, 0, newSize.width, newSize.height);
  }

  @override
  void render(Canvas c) {
    c.drawRect(bgRect, bgColor);
  }

  @override
  void update(double t) { }
}
