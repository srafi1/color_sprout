import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/cupertino.dart';

class Tile extends PositionComponent with Tapable {
  Offset center;

  int colorID;
  Rect mainRect;
  Paint mainPaint;

  int targetColorID;
  Rect targetRect;
  Paint targetPaint;

  int nextColorID;
  Rect nextRect;
  Paint nextPaint;

  bool growing;
  bool shrinking;

  List<Tile> neighbors;

  Tile() {
    center = Offset(x + width/2, y + height/2);

    colorID = -1;
    mainRect = Rect.fromCenter(center: center, width: 0.8*width, height: 0.8*height);
    mainPaint = Paint()..color = GameColors.background;

    targetColorID = -1;
    targetRect = Rect.fromCenter(center: center, width: width, height: height);
    targetPaint = Paint()..color = GameColors.background;

    nextColorID = -1;
    nextRect = Rect.fromCenter(center: center, width: 0, height: 0);
    nextPaint = Paint()..color = GameColors.background;

    growing = false;
    shrinking = false;
  }

  void setNextColor(int colorID) {
    nextColorID = colorID;
    nextPaint.color = GameColors.tileColors[colorID];
    shrinking = true;
  }

  @override
  void render(Canvas c) {
    c.drawRect(targetRect, targetPaint);
    c.drawRect(mainRect, mainPaint);
    if (growing) {
      c.drawRect(nextRect, nextPaint);
    }
  }

  @override
  void update(double t) {
    if (growing) {
      nextRect = nextRect.inflate(width*t);
      if (nextRect.width >= mainRect.width) {
        growing = false;
        colorID = nextColorID;
        mainRect = Rect.fromCenter(center: center, width: 0.8*width, height: 0.8*height);
        mainPaint.color = GameColors.tileColors[nextColorID];
        nextColorID = -1;
        nextRect = nextRect.deflate(nextRect.width);
      }
    } else if (shrinking) {
      mainRect = mainRect.deflate(width*t);
      if (mainRect.width <= 0) {
        shrinking = false;
        mainRect = Rect.fromCenter(center: center, width: 0.8*width, height: 0.8*height);
        mainPaint.color = GameColors.background;
      }
    }
  }

  @override
  void onTapUp(TapUpDetails tap) {
    neighbors.forEach((Tile neighbor) {
      setNextColor(colorID);
    });
    shrinking = true;
  }
}
