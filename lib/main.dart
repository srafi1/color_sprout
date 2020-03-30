import 'package:color_sprout/game_controller.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  GameController gc = GameController();
  runApp(gc.widget);

  SharedPreferences storage = await SharedPreferences.getInstance();
  gc.storage = storage;

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
}
