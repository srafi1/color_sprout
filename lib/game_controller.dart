import 'dart:ui';

import 'package:color_sprout/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:color_sprout/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends Game {
  SharedPreferences storage;
  Size screenSize;
  double baseTextSize;
  State state;

  MainMenu mainMenu;

  GameController() {
    initialize();
    state = State.loading;
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    storage = await SharedPreferences.getInstance();
    baseTextSize = screenSize.height / 20;
    mainMenu = MainMenu(this);
    state = State.menu;
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFF8F8FF);
    c.drawRect(background, backgroundPaint);

    switch (state) {
      case State.loading:
      break;
      case State.menu:
        mainMenu.render(c);
        break;
      case State.game:
      break;
      case State.endgame:
    }
  }

  void update(double t) {
  }

  void resize(Size size) {
    screenSize = size;
  }

  void onTapDown(TapDownDetails tap) {
    print("Tapped at: ${tap.globalPosition}");
  }

}