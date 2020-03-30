import 'package:color_sprout/components/background.dart';
import 'package:color_sprout/components/game_component.dart';
import 'package:color_sprout/level_data.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'game_colors.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends BaseGame with HasWidgetsOverlay {
  SharedPreferences storage;
  int level;
  TextComponent levelText;
  TextStyle textStyle;
  GameComponent game;

  GameController(Size initialSize, this.storage) {
    level = storage.getInt("level") ?? 0;
    levelText = TextComponent("Level ${level+1}")
        ..anchor = Anchor.bottomLeft
        ..x = 10
        ..y = initialSize.height/2 - initialSize.width/2 - 10;

    textStyle = TextStyle(
      color: Colors.black,
      fontSize: 40,
    );
    
    LevelData dummyLevel = LevelData()
        ..gridSize = 3
        ..start = [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]]
        ..target = [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]];

    game = GameComponent(this, initialSize)
        ..x = 0
        ..y = initialSize.height/2 - initialSize.width/2
        ..width = initialSize.width
        ..height = initialSize.width;
    game.intializeLevel(dummyLevel);
    
    add(BackgroundComponent());
    add(game);
    add(levelText);

    addWidgetOverlay(
      "mainMenu",
      buildMainMenu()
    );
  }

  Widget buildIconButton({Color color, Icon icon, Function callback, double size: 50}) {
    return 
      Padding(
        padding: EdgeInsets.all(10),
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            color: color,
            child: IconButton(
              icon: icon,
              iconSize: size / 2,
              color: Colors.white,
              onPressed: callback,
            ),
          )
        ),
      );
  }

  Widget buildMainMenu() {
    return 
      Card(
        margin: EdgeInsets.only(),
        color: GameColors.background,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Color Sprout", style: textStyle),
              buildIconButton(
                icon: Icon(Icons.play_arrow),
                color: Colors.blue,
                callback: () {
                  print("Clicked play");
                  removeWidgetOverlay('mainMenu');
                },
                size: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildIconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.orange,
                    callback: () { print("Clicked settings"); },
                  ),
                  buildIconButton(
                    icon: Icon(Icons.list),
                    color: Colors.green,
                    callback: () { print("Clicked list"); },
                  ),
                  buildIconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.red,
                    callback: () { print("Clicked favorite"); },
                  ),
                ],
              )
            ]
          )
        )
      );
  }
}
class GridBackgroundComponent {
}

