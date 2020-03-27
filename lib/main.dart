import 'package:color_sprout/game_controller.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() async {
  GameController gc = GameController();
  runApp(gc.widget);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  TapGestureRecognizer tap = TapGestureRecognizer();
  tap.onTapDown = gc.onTapDown;
  flameUtil.addGestureRecognizer(tap);
}