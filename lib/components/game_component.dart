import 'dart:ui';

import 'package:color_sprout/components/grid_background.dart';
import 'package:color_sprout/components/tile.dart';
import 'package:color_sprout/game_controller.dart';
import 'package:color_sprout/level_data.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game/game.dart';
import 'package:flutter/cupertino.dart';

class GameComponent extends PositionComponent with HasGameRef, Tapable, ComposedComponent {
  @override
  Game gameRef;
  GameController game;
  Size screenSize;

  bool allowInput;
  GridBackground gridBackground;
  List<List<Tile>> grid;
  int numUpdating;
  bool sentCompletion;

  GameComponent(this.game, this.screenSize) {
    allowInput = true;
    sentCompletion = false;

    gridBackground = GridBackground();
    gridBackground.resize(screenSize);
  }

  void initializeLevel(LevelData levelData) {
    numUpdating = 0;
    allowInput = true;
    sentCompletion = false;
    components.clear();
    components..add(gridBackground);

    // create grid
    double tileSize = width / levelData.gridSize;
    grid = List();
    for (int i = 0; i < levelData.gridSize + 2; i++) {
      grid.add([]);
      for (int j = 0; j < levelData.gridSize + 2; j++) {
        grid[i].add(Tile(this)
            ..x = (i-1)*tileSize
            ..y = y + (j-1)*tileSize
            ..width = tileSize
            ..height = tileSize);
        grid[i][j].resize(screenSize);
      }
    }

    // set neighbors
    for (int i = 1; i <= levelData.gridSize; i++) {
      for (int j = 1; j <= levelData.gridSize; j++) {
        grid[i][j].neighbors.add(grid[i][j+1]);
        grid[i][j].neighbors.add(grid[i][j-1]);
        grid[i][j].neighbors.add(grid[i+1][j]);
        grid[i][j].neighbors.add(grid[i-1][j]);
      }
    }

    // set level data
    for (int i = 1; i <= levelData.gridSize; i++) {
      for (int j = 1; j <= levelData.gridSize; j++) {
        int x = i-1;
        int y = j-1;
        if (levelData.start[x][y] != -1) {
          grid[i][j].setNextColor(levelData.start[x][y]);
        }
        if (levelData.target[x][y] != -1) {
          grid[i][j].setTarget(levelData.target[x][y]);
        }
      }
    }

    for (int i = 1; i <= levelData.gridSize; i++) {
      for (int j = 1; j <= levelData.gridSize; j++) {
        components..add(grid[i][j]);
        grid[i][j].onScreen = true;
      }
    }
  }

  @override
  void resize(Size size) {
    super.resize(size);
    screenSize = size;
  }

  @override
  Rect toRect() {
    return gridBackground.bgRect;
  }

  void checkCompletion() {
    numUpdating--;
    if (numUpdating > 0) {
      return;
    }
    bool complete = true;
    for (int i = 1; i < grid.length-1; i++) {
      for (int j = 1; j < grid.length-1; j++) {
        if (grid[i][j].colorID != grid[i][j].targetColorID) {
          complete = false;
        }
      }
    }
    if (complete && !sentCompletion) {
      sentCompletion = true;
      allowInput = false;
      game.completeLevel();
    }
  }

  void printState() {
    print("level:");
    grid.sublist(1, grid.length-1).forEach((row) {
      List<int> pr = row.sublist(1, row.length-1).map( (tile) {return tile.colorID;} ).toList();
      print("$pr,");
    });
  }
}
