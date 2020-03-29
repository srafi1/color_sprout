import 'package:color_sprout/components/background.dart';
import 'package:flame/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends BaseGame {
    SharedPreferences storage;

    GameController() {
        add(BackgroundComponent());
    }
}
