import 'dart:ui';

import 'package:color_sprout/components/grid_background.dart';
import 'package:color_sprout/components/tile.dart';
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
  Size screenSize;

  bool allowInput;
  GridBackground gridBackground;
  List<List<Tile>> grid;

  GameComponent(this.gameRef, Size initialSize) {
    allowInput = true;

    gridBackground = GridBackground();
    gridBackground.resize(initialSize);

    screenSize = initialSize;
  }

  void intializeLevel(LevelData levelData) {
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
}
