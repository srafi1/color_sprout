import 'package:color_sprout/components/background.dart';
import 'package:color_sprout/components/game_component.dart';
import 'package:color_sprout/level_data.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'game_colors.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class GameController extends BaseGame with HasWidgetsOverlay {
  SharedPreferences storage;
  int level;
  TextComponent levelText;
  TextStyle largeText;
  TextStyle normalText;
  GameComponent game;
  bool arcadeMode;
  bool chosenLevel;

  GameController(Size initialSize, this.storage) {
    level = storage.getInt("level") ?? 0;
    chosenLevel = false;
    arcadeMode = level > Levels.maxLevel();
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
      "gameBottomUI",
      buildGameBottom()
    );

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
    if (!arcadeMode) {
      chosenLevel = true;
      level++;
      int highestLevel = storage.getInt("level") ?? 0;
      if (level > highestLevel) {
        highestLevel = level;
      }
      if (level > Levels.maxLevel()) {
        arcadeMode = true;
      }
      storage.setInt("level", highestLevel);
    }
    addWidgetOverlay(
        "levelCompleteMenu",
        buildLevelCompleteMenu()
    );
    chosenLevel = false;
  }


  Widget buildIconButton({Color color, FaIcon icon, Function callback, double size: 50}) {
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
                icon: FaIcon(Icons.play_arrow),
                color: Colors.green,
                callback: () {
                  if (arcadeMode) {
                    levelText.text = "Arcade mode";
                    LevelData level = Levels.randomFlips(Levels.randomLevel(7), 15);
                    game.initializeLevel(level);
                  } else {
                    loadLevel();
                  }
                  removeWidgetOverlay('mainMenu');
                },
                size: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildIconButton(
                    icon: FaIcon(FontAwesomeIcons.bars),
                    color: Colors.blue,
                    callback: () {
                      removeWidgetOverlay("mainMenu");
                      addWidgetOverlay(
                        "levelsMenu",
                        buildLevelsMenu()
                      );
                    },
                  ),
                  buildIconButton(
                    icon: FaIcon(Icons.favorite),
                    color: Colors.red,
                    callback: () {
                      String url = "https://play.google.com/store/apps/details?id=com.shakilrafi.color_sprout";
                      canLaunch(url)
                          .then((bool able) {
                            if (able) {
                              launch(url);
                            } else {
                              print("cant rate");
                            }
                          });
                    },
                  ),
                ],
              )
            ]
          )
        )
      );
  }

  Widget buildLevelsMenu() {
    List<Widget> templateLevels = List.generate(Levels.maxTemplate()+1, (i) {
      return RaisedButton(
          color: Colors.green,
          child: Text("${i+1}", style: normalText.copyWith(color: Colors.white)),
          onPressed: () {
            level = i;
            levelText.text = "Template ${level+1}";
            game.initializeLevel(Levels.loadTemplate(level));
            removeWidgetOverlay("levelsMenu");
          },
      );
    });
    List<Widget> randomTemplateLevels = List.generate(3, (i) {
      i = i + 5;
      return RaisedButton(
          color: Colors.green,
          child: Text("R$i", style: normalText.copyWith(color: Colors.white)),
          onPressed: () {
            levelText.text = "Random Template: $i";
            game.initializeLevel(Levels.randomFlips(Levels.loadTemplate(-1*i), 15));
            removeWidgetOverlay("levelsMenu");
          },
      );
    });

    int highestLevel = storage.getInt("level") ?? 0;
    if (highestLevel > Levels.maxLevel()) {
      highestLevel--;
    }
    List<Widget> unlockedLevels = List.generate(highestLevel+1, (i) {
      return RaisedButton(
          padding: EdgeInsets.all(0),
          color: Colors.blue,
          child: Text("${i+1}", style: normalText.copyWith(color: Colors.white)),
          onPressed: () {
            chosenLevel = true;
            level = i;
            loadLevel();
            removeWidgetOverlay("levelsMenu");
          },
      );
    });
    List<Widget> lockedLevels = List.generate(Levels.maxLevel()-highestLevel, (i) {
      return RaisedButton(
        padding: EdgeInsets.all(0),
        color: Colors.grey,
        child: Text(
          "${highestLevel+i+2}",
          style: normalText.copyWith(color: Colors.white)
        ),
        onPressed: null,
      );
    });

    return
      Card(
        margin: EdgeInsets.only(),
        color: GameColors.background,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 100),
              Text("Levels", style: largeText),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 5,
                  children: unlockedLevels + lockedLevels,
                )
              ),
              buildIconButton(
                icon: FaIcon(FontAwesomeIcons.home),
                color: Colors.red,
                size: 70,
                callback: () {
                  removeWidgetOverlay("levelsMenu");
                  addWidgetOverlay(
                    "mainMenu",
                    buildMainMenu()
                  );
                }
              ),
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
        icon: FaIcon(FontAwesomeIcons.home),
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
        icon: FaIcon(FontAwesomeIcons.bars),
        callback: () {
          removeWidgetOverlay("levelCompleteMenu");
          addWidgetOverlay(
            "levelsMenu",
            buildLevelsMenu()
          );
        }
      ),
    ];

    if (arcadeMode || level > Levels.maxLevel()) {
      if (!chosenLevel) {
        text = "Arcade level completed!";
      }
      buttons.add(
        buildIconButton(
          color: Colors.green,
          icon: FaIcon(FontAwesomeIcons.arrowRight),
          callback: () {
            levelText.text = "Arcade mode";
            LevelData level = Levels.randomFlips(Levels.randomLevel(7), 15);
            game.initializeLevel(level);
            removeWidgetOverlay("levelCompleteMenu");
          },
        )
      );
    } else {
      buttons.add(
        buildIconButton(
          color: Colors.green,
          icon: FaIcon(FontAwesomeIcons.arrowRight),
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
          elevation: 0,
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

  Widget buildGameBottom() {
    return
      Container(
        width:double.infinity,
        height:double.infinity,
        padding: EdgeInsets.all(50),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              elevation: 0,
              color: GameColors.background,
              child: buildIconButton(
                icon: FaIcon(FontAwesomeIcons.home),
                color: Colors.red,
                callback: () {
                  addWidgetOverlay(
                    "goHomePrompt",
                    buildGoHomePrompt()
                  );
                },
              )
            ),
            Card(
              elevation: 0,
              color: GameColors.background,
              child: buildIconButton(
                icon: FaIcon(FontAwesomeIcons.undoAlt),
                color: Colors.blue,
                callback: () {
                  addWidgetOverlay(
                    "resetPrompt",
                    buildResetPrompt()
                  );
                },
              ),
            ),
            //Card(
              //elevation: 0,
              //color: GameColors.background,
              //child: buildIconButton(
                //icon: Icon(Icons.code),
                //color: Colors.blue,
                //callback: () {
                  //game.printState();
                //},
              //),
            //),
          ],
        ),
      );
  }

  Widget buildGoHomePrompt() {
    return 
      Center(
        child: Card(
          elevation: 0,
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
                Text("Go to main menu?", style: normalText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildIconButton(
                      icon: FaIcon(FontAwesomeIcons.times),
                      color: Colors.red,
                      callback: () {
                        removeWidgetOverlay("goHomePrompt");
                      }
                    ),
                    buildIconButton(
                      icon: FaIcon(FontAwesomeIcons.check),
                      color: Colors.green,
                      callback: () {
                        removeWidgetOverlay("goHomePrompt");
                        addWidgetOverlay(
                          "mainMenu",
                          buildMainMenu()
                        );
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget buildResetPrompt() {
    return 
      Center(
        child: Card(
          elevation: 0,
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
                Text("Reset level?", style: normalText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildIconButton(
                      icon: FaIcon(FontAwesomeIcons.times),
                      color: Colors.red,
                      callback: () {
                        removeWidgetOverlay("resetPrompt");
                      }
                    ),
                    buildIconButton(
                      icon: FaIcon(FontAwesomeIcons.check),
                      color: Colors.green,
                      callback: () {
                        removeWidgetOverlay("resetPrompt");
                        game.reloadLevel();
                      }
                    ),
                  ],
                )
              ],
            )
          ),
        )
      );
  }
}
