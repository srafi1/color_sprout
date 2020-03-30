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
  TextStyle largeText;
  TextStyle normalText;
  GameComponent game;

  GameController(Size initialSize, this.storage) {
    level = storage.getInt("level") ?? 0;
    levelText = TextComponent("Level ${level+1}")
        ..anchor = Anchor.bottomLeft
        ..x = 10
        ..y = initialSize.height/2 - initialSize.width/2 - 10;

    largeText = TextStyle(
      color: Colors.black,
      fontSize: 40,
    );

    normalText = TextStyle(
      color: Colors.black,
      fontSize: 32,
    );

    game = GameComponent(this, initialSize)
        ..x = 0
        ..y = initialSize.height/2 - initialSize.width/2
        ..width = initialSize.width
        ..height = initialSize.width;

    add(BackgroundComponent());
    add(game);
    add(levelText);

    addWidgetOverlay(
      "mainMenu",
      buildMainMenu()
    );
  }

  void loadLevel() {
    levelText.text = "Level ${level+1}";
    game.initializeLevel(Levels.loadLevel(level));
  }

  void completeLevel() {
    level++;
    int highestLevel = storage.getInt("level") ?? 0;
    if (level > highestLevel && level <= Levels.maxLevel()) {
      highestLevel = level;
    }
    storage.setInt("level", highestLevel);
    addWidgetOverlay(
        "levelCompleteMenu",
        buildLevelCompleteMenu()
    );
    if (level > Levels.maxLevel()) {
      level--;
    }
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
              Text("Color Sprout", style: largeText),
              buildIconButton(
                icon: Icon(Icons.play_arrow),
                color: Colors.green,
                callback: () {
                  loadLevel();
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
                    color: Colors.blue,
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

  Widget buildLevelCompleteMenu() {
    String text = "Level complete!";
    List<Widget> buttons = [
      buildIconButton(
        color: Colors.red,
        icon: Icon(Icons.home),
        callback: () {
        removeWidgetOverlay("levelCompleteMenu");
        addWidgetOverlay(
          "mainMenu",
          buildMainMenu()
        );
        }
      ),
      buildIconButton(
        color: Colors.blue,
        icon: Icon(Icons.list),
        callback: () {
        print("levels");
        }
      ),
    ];

    if (level > Levels.maxLevel()) {
      text = "All levels completed!";
    } else {
      buttons.add(
        buildIconButton(
          color: Colors.green,
          icon: Icon(Icons.play_arrow),
          callback: () {
            loadLevel();
            removeWidgetOverlay("levelCompleteMenu");
          },
        )
      );
    }

    return
      Center(
        child: Card(
          color: GameColors.background,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(text, style: normalText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttons,
                )
              ],
            )
          ),
        )
      );
  }
}
