import 'dart:ui';

import 'package:color_sprout/components/grid_background.dart';
import 'package:color_sprout/components/tile.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game/game.dart';
import 'package:flutter/cupertino.dart';

class GameComponent extends PositionComponent with HasGameRef, Tapable, ComposedComponent {
  @override
  Game gameRef;

  bool allowInput;
  GridBackground gridBackground;
  List<List<Tile>> grid;

  GameComponent(this.gameRef, Size initialSize) {
    allowInput = true;

    gridBackground = GridBackground();
    gridBackground.resize(initialSize);
    components..add(gridBackground);

    // create grid
    int gridSize = 5;
    double tileSize = initialSize.width / gridSize;
    double topHeight = initialSize.height/2 - initialSize.width/2;
    grid = List();
    for (int i = 0; i < gridSize + 2; i++) {
      grid.add([]);
      for (int j = 0; j < gridSize + 2; j++) {
        grid[i].add(Tile(this)
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
    grid[3][3].setNextColor(2);

    for (int i = 1; i <= gridSize; i++) {
      for (int j = 1; j <= gridSize; j++) {
        components..add(grid[i][j]);
      }
    }
  }

  @override
  Rect toRect() {
    return gridBackground.bgRect;
  }
}
