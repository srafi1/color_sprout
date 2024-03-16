import 'package:color_sprout/components/background.dart';
import 'package:color_sprout/components/game_component.dart';
import 'package:color_sprout/level_data.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'game_colors.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class GameController extends FlameGame with TapDetector {
  SharedPreferences storage;
  int level = 0;
  TextComponent? levelText;
  TextStyle largeText = TextStyle(
    color: Colors.black,
    fontSize: 40,
  );

  TextStyle normalText = TextStyle(
      color: Colors.black,
      fontSize: 32,
    );
  GameComponent? game;
  bool arcadeMode = false;
  bool chosenLevel = false;

  GameController(this.storage) {
    level = storage.getInt("level") ?? 0;
    arcadeMode = level > Levels.maxLevel();
  }

  @override
  void onLoad() {
    Size initialSize = Size(size.x, size.y);
    levelText = TextComponent()
      ..text = "Level ${level+1}"
      ..textRenderer = TextPaint(style: normalText)
      ..anchor = Anchor.bottomLeft
      ..x = 10
      ..y = initialSize.height/2 - initialSize.width/2 - 10;

    game = GameComponent(this, size)
      ..x = 0
      ..y = initialSize.height/2 - initialSize.width/2
      ..width = initialSize.width
      ..height = initialSize.width;

    add(BackgroundComponent());
    add(game!);
    add(levelText!);
  }

  void loadLevel() {
    levelText!.text = "Level ${level+1}";
    game!.initializeLevel(Levels.loadLevel(level));
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
    overlays.add('levelCompleteMenu');
    chosenLevel = false;
  }


  Widget buildIconButton({required Color color, required FaIcon icon, required void Function() callback, double size = 50}) {
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

  Widget buildMainMenu(BuildContext, GameController) {
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
                    levelText!.text = "Arcade mode";
                    LevelData level = Levels.randomFlips(Levels.randomLevel(7), 15);
                    game!.initializeLevel(level);
                  } else {
                    loadLevel();
                  }
                  overlays.remove('mainMenu');
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
                      overlays.remove("mainMenu");
                      overlays.add("levelsMenu");
                    },
                  ),
                  buildIconButton(
                    icon: FaIcon(Icons.favorite),
                    color: Colors.red,
                    callback: () {
                      Uri url = Uri.parse("https://play.google.com/store/apps/details?id=com.shakilrafi.color_sprout");
                      canLaunchUrl(url)
                          .then((bool able) {
                            if (able) {
                              launchUrl(url);
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

  Widget buildLevelsMenu(BuildContext, GameController) {
    List<Widget> templateLevels = List.generate(Levels.maxTemplate()+1, (i) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text("${i+1}", style: normalText.copyWith(color: Colors.white)),
          onPressed: () {
            level = i;
            levelText!.text = "Template ${level+1}";
            game!.initializeLevel(Levels.loadTemplate(level));
            overlays.remove("levelsMenu");
          },
      );
    });
    List<Widget> randomTemplateLevels = List.generate(3, (i) {
      i = i + 5;
      return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text("R$i", style: normalText.copyWith(color: Colors.white)),
          onPressed: () {
            levelText!.text = "Random Template: $i";
            game!.initializeLevel(Levels.randomFlips(Levels.loadTemplate(-1*i), 15));
            overlays.remove("levelsMenu");
          },
      );
    });

    int highestLevel = storage.getInt("level") ?? 0;
    if (highestLevel > Levels.maxLevel()) {
      highestLevel--;
    }
    List<Widget> unlockedLevels = List.generate(highestLevel+1, (i) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.all(0),),
          child: Text("${i+1}", style: normalText.copyWith(color: Colors.white)),
          onPressed: () {
            chosenLevel = true;
            level = i;
            loadLevel();
            overlays.remove("levelsMenu");
          },
      );
    });
    List<Widget> lockedLevels = List.generate(Levels.maxLevel()-highestLevel, (i) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, padding: EdgeInsets.all(0)),
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
                icon: FaIcon(FontAwesomeIcons.house),
                color: Colors.red,
                size: 70,
                callback: () {
                  overlays.remove("levelsMenu");
                  overlays.add("mainMenu");
                }
              ),
            ]
          )
        )
      );
  }

  Widget buildLevelCompleteMenu(BuildContext, GameController) {
    String text = "Level complete!";
    List<Widget> buttons = [
      buildIconButton(
        color: Colors.red,
        icon: FaIcon(FontAwesomeIcons.house),
        callback: () {
        overlays.remove("levelCompleteMenu");
        overlays.add("mainMenu");
        }
      ),
      buildIconButton(
        color: Colors.blue,
        icon: FaIcon(FontAwesomeIcons.bars),
        callback: () {
          overlays.remove("levelCompleteMenu");
          overlays.add("levelsMenu");
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
            levelText!.text = "Arcade mode";
            LevelData level = Levels.randomFlips(Levels.randomLevel(7), 15);
            game!.initializeLevel(level);
            overlays.remove("levelCompleteMenu");
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
            overlays.remove("levelCompleteMenu");
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

  Widget buildGameBottom(BuildContext, GameController) {
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
                icon: FaIcon(FontAwesomeIcons.house),
                color: Colors.red,
                callback: () {
                  overlays.add("goHomePrompt");
                },
              )
            ),
            Card(
              elevation: 0,
              color: GameColors.background,
              child: buildIconButton(
                icon: FaIcon(FontAwesomeIcons.rotateLeft),
                color: Colors.blue,
                callback: () {
                  overlays.add("resetPrompt");
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

  Widget buildGoHomePrompt(BuildContext, GameController) {
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
                      icon: FaIcon(FontAwesomeIcons.xmark),
                      color: Colors.red,
                      callback: () {
                        overlays.remove("goHomePrompt");
                      }
                    ),
                    buildIconButton(
                      icon: FaIcon(FontAwesomeIcons.check),
                      color: Colors.green,
                      callback: () {
                        overlays.remove("goHomePrompt");
                        overlays.add("mainMenu");
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

  Widget buildResetPrompt(BuildContext, GameController) {
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
                      icon: FaIcon(FontAwesomeIcons.xmark),
                      color: Colors.red,
                      callback: () {
                        overlays.remove("resetPrompt");
                      }
                    ),
                    buildIconButton(
                      icon: FaIcon(FontAwesomeIcons.check),
                      color: Colors.green,
                      callback: () {
                        overlays.remove("resetPrompt");
                        game!.reloadLevel();
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

  Map<String, Widget Function(BuildContext, GameController)> overlayBuilders() {
    return {
      "gameBottomUI": buildGameBottom,
      "mainMenu": buildMainMenu,
      "levelCompleteMenu": buildLevelCompleteMenu,
      "levelsMenu": buildLevelsMenu,
      "goHomePrompt": buildGoHomePrompt,
      "resetPrompt": buildResetPrompt,
    };
  }
}
