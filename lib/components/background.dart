import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class BackgroundComponent extends Component {
  Rect? bgRect;
  Paint? bgColor;

  BackgroundComponent() : bgColor = Paint()..color = GameColors.background;

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    bgRect = Rect.fromLTWH(0, 0, newSize.x, newSize.y);
  }

  @override
  void render(Canvas c) {
    c.drawRect(bgRect!, bgColor!);
  }

  @override
  void update(double t) { }
}
