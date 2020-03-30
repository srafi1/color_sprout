import 'package:color_sprout/components/background.dart';
import 'package:color_sprout/components/grid_background.dart';
import 'components/tile.dart';
import 'game_colors.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends BaseGame with HasWidgetsOverlay {
  SharedPreferences storage;
  TextStyle textStyle;
  int level;
  List<List<Tile>> grid;

  GameController(Size initialSize, this.storage) {
    level = storage.getInt("level") ?? 0;

    textStyle = TextStyle(
      color: Colors.black,
      fontSize: 40,
    );

    // create grid
    int gridSize = 5;
    double tileSize = initialSize.width / gridSize;
    double topHeight = initialSize.height/2 - initialSize.width/2;
    grid = List();
    for (int i = 0; i < gridSize + 2; i++) {
      grid.add([]);
      for (int j = 0; j < gridSize + 2; j++) {
        grid[i].add(Tile()
            ..x = (i-1)*tileSize
            ..y = topHeight + (j-1)*tileSize
            ..width = tileSize
            ..height = tileSize);
        grid[i][j].resize(initialSize);
      }
    }

    // set neighbors
    for (int i = 1; i <= gridSize; i++) {
      for (int j = 1; j <= gridSize; j++) {
        grid[i][j].neighbors.add(grid[i][j+1]);
        grid[i][j].neighbors.add(grid[i][j-1]);
        grid[i][j].neighbors.add(grid[i+1][j]);
        grid[i][j].neighbors.add(grid[i-1][j]);
      }
    }
    grid[3][3].setTarget(2);
    grid[2][2].setNextColor(1);

    add(BackgroundComponent());
    add(GridBackground());
    for (int i = 1; i <= gridSize; i++) {
      for (int j = 1; j <= gridSize; j++) {
        add(grid[i][j]);
      }
    }

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

