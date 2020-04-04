import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:color_sprout/components/game_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flutter/cupertino.dart';

class Tile extends PositionComponent with Tapable {
  GameComponent game;
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
  bool onScreen;

  Tile(this.game) {
    colorID = -1;
    mainPaint = Paint()..color = GameColors.background;

    targetColorID = -1;
    targetPaint = Paint()..color = GameColors.background;

    nextColorID = -1;
    nextPaint = Paint()..color = GameColors.background;

    growing = false;
    shrinking = false;

    neighbors = List();
    onScreen = false;
  }

  void resize(Size size) {
    super.resize(size);
    center = Offset(x + width/2, y + height/2);
    mainRect = Rect.fromCenter(center: center, width: 0.8*width, height: 0.8*height);
    targetRect = Rect.fromCenter(center: center, width: 0.95*width, height: 0.95*height);
    nextRect = Rect.fromCenter(center: center, width: 0, height: 0);
  }

  void setNextColor(int colorID) {
    nextColorID = colorID;
    nextPaint.color = GameColors.tileColors[colorID];
    nextRect = Rect.fromCenter(center: center, width: 0, height: 0);
    growing = true;
  }

  void setTarget(int colorID) {
    targetColorID = colorID;
    targetPaint.color = GameColors.targetColors[colorID];
  }

  @override
  void render(Canvas c) {
    c.drawRect(targetRect, targetPaint);
    if (shrinking) {
      c.drawRect(nextRect, nextPaint);
    }
    c.drawRect(mainRect, mainPaint);
    if (growing) {
      c.drawRect(nextRect, nextPaint);
    }
  }

  @override
  void update(double t) {
    if (growing) {
      nextRect = nextRect.inflate(2*width*t);
      if (nextRect.width >= mainRect.width) {
        growing = false;
        colorID = nextColorID;
        mainPaint.color = GameColors.tileColors[nextColorID];
        nextColorID = -1;
        nextRect = Rect.fromCenter(center: center, width: 0, height: 0);
        game.checkCompletion();
      }
    } else if (shrinking) {
      mainRect = mainRect.deflate(2*width*t);
      if (mainRect.width <= 0) {
        game.allowInput = true;
        shrinking = false;
        colorID = -1;
        mainRect = Rect.fromCenter(center: center, width: 0.8*width, height: 0.8*height);
        mainPaint.color = GameColors.background;
        game.checkCompletion();
      }
    }
  }

  @override
  void onTapUp(TapUpDetails tap) {
    if (colorID != -1 && game.allowInput) {
      game.allowInput = false;
      game.numUpdating = 1 + neighbors.where((tile) {return tile.onScreen;}).length;
      neighbors.forEach((Tile neighbor) {
        neighbor.setNextColor(colorID);
      });
      shrinking = true;
      nextRect = Rect.fromCenter(center: center, width: 0.8*width, height: 0.8*height);
      nextPaint.color = GameColors.background;
    }
  }
}
