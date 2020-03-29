import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/cupertino.dart';

class BackgroundComponent extends Component with Tapable {
  Rect bgRect;
  Paint bgColor;

  BackgroundComponent() : bgColor = Paint()..color = Color(0xFFF8F8FF);

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

  @override
  Rect toRect() {
    return bgRect;
  }

  @override
  void onTapDown(TapDownDetails tap) {
    print("TapDown at: ${tap.globalPosition}");
  }
}
