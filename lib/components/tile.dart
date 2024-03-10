import 'dart:ui';

import 'package:color_sprout/game_colors.dart';
import 'package:color_sprout/components/game_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';

class Tile extends PositionComponent with TapCallbacks {
  GameComponent game;
  Offset? centerOffset;

  int colorID = -1;
  Rect? mainRect;
  Paint mainPaint = Paint()..color = GameColors.background;

  int targetColorID = -1;
  Rect? targetRect;
  Paint targetPaint = Paint()..color = GameColors.background;

  int nextColorID = -1;
  Rect? nextRect;
  Paint nextPaint = Paint()..color = GameColors.background;

  bool growing = false;
  bool shrinking = false;

  List<Tile> neighbors = List.empty(growable: true);
  bool onScreen = false;

  Tile(this.game, double x, double y, double width, double height) : super(position: Vector2(x, y), size: Vector2(width, height)) {}

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    centerOffset = Offset(x + width/2, y + height/2);
    mainRect = Rect.fromCenter(center: centerOffset!, width: 0.8*width, height: 0.8*height);
    targetRect = Rect.fromCenter(center: centerOffset!, width: 0.95*width, height: 0.95*height);
    nextRect = Rect.fromCenter(center: centerOffset!, width: 0, height: 0);
  }

  void setNextColor(int colorID) {
    nextColorID = colorID;
    nextPaint.color = GameColors.tileColors[colorID];
    nextRect = Rect.fromCenter(center: centerOffset!, width: 0, height: 0);
    growing = true;
  }

  void setTarget(int colorID) {
    targetColorID = colorID;
    targetPaint.color = GameColors.targetColors[colorID];
  }

  @override
  void render(Canvas c) {
    c.drawRect(targetRect!, targetPaint);
    if (shrinking) {
      c.drawRect(nextRect!, nextPaint);
    }
    c.drawRect(mainRect!, mainPaint);
    if (growing) {
      c.drawRect(nextRect!, nextPaint);
    }
  }

  @override
  void update(double t) {
    if (growing) {
      nextRect = nextRect!.inflate(2*width*t);
      if (nextRect!.width >= mainRect!.width) {
        growing = false;
        colorID = nextColorID;
        mainPaint.color = GameColors.tileColors[nextColorID];
        nextColorID = -1;
        nextRect = Rect.fromCenter(center: centerOffset!, width: 0, height: 0);
        game.checkCompletion();
      }
    } else if (shrinking) {
      mainRect = mainRect!.deflate(2*width*t);
      if (mainRect!.width <= 0) {
        game.allowInput = true;
        shrinking = false;
        colorID = -1;
        mainRect = Rect.fromCenter(center: centerOffset!, width: 0.8*width, height: 0.8*height);
        mainPaint.color = GameColors.background;
        game.checkCompletion();
      }
    }
  }

  @override
  void onTapUp(TapUpEvent tap) {
    if (colorID != -1 && game.allowInput) {
      game.allowInput = false;
      game.numUpdating = 1 + neighbors.where((tile) {return tile.onScreen;}).length;
      neighbors.forEach((Tile neighbor) {
        neighbor.setNextColor(colorID);
      });
      shrinking = true;
      nextRect = Rect.fromCenter(center: centerOffset!, width: 0.8*width, height: 0.8*height);
      nextPaint.color = GameColors.background;
    }
  }
}
