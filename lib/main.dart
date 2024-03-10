import 'package:color_sprout/game_controller.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setPortrait();

  SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController(storage);
  runApp(GameWidget(
    game: gameController,
    overlayBuilderMap: gameController.overlayBuilders(),
    initialActiveOverlays: const ['gameBottomUI', 'mainMenu']
  ));
}
