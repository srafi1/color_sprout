import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';

class GameController extends Game {
  Size screenSize;

  GameController() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFF8F8FF);
    c.drawRect(background, backgroundPaint);
  }

  void update(double t) {
  }

  void resize(Size size) {
    screenSize = size;
  }

}