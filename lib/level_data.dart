import 'dart:math';

import 'package:color_sprout/game_colors.dart';

class LevelData {
  int gridSize;
  List<List<int>> start;
  List<List<int>> target;
  LevelData({this.gridSize, this.start, this.target});
}

class Levels {
  static List<LevelData> levels = [
    // 1
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 0, -1, 0, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
    ),
    // 2
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 0, 0, 0, -1],
          [-1, 0, -1, 0, -1],
          [-1, -1, 0, -1, -1],
        ], 
    ),
    // 3
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, 0, 0, -1, -1],
          [0, 0, -1, 0, -1],
          [0, -1, 0, 0, -1],
          [-1, 0, 0, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
    ),
    // 4
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, 0, -1, -1],
          [-1, 0, 0, 0, -1],
          [-1, 0, -1, 0, -1],
          [-1, 0, 0, 0, -1],
          [-1, -1, 0, -1, -1],
        ], 
    ),
    // 5
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, 0, -1, -1],
          [-1, 0, 0, 0, -1],
          [0, 0, -1, 0, 0],
          [-1, 0, 0, 0, -1],
          [-1, -1, 0, -1, -1],
        ], 
    ),
    // 6
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, 0, -1, -1],
          [-1, 0, -1, 0, -1],
          [-1, -1, 0, -1, -1],
          [-1, 1, -1, 1, -1],
          [-1, -1, 1, -1, -1],
        ], 
    ),
    // 7
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, 0, 0, -1, -1],
          [0, -1, 1, 0, -1],
          [-1, 1, -1, 1, -1],
          [1, -1, 1, 1, -1],
          [-1, 1, 1, -1, -1],
        ], 
    ),
    // 8
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, 0, 0, 0, -1],
          [0, 1, 0, -1, 0],
          [1, -1, 1, 0, -1],
          [-1, 1, 1, 1, -1],
          [-1, -1, 1, -1, -1],
        ], 
    ),
    // 9
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, 0, 0, 0, -1],
          [-1, 0, -1, 0, -1],
          [-1, 1, 1, 1, -1],
          [-1, 1, -1, 1, -1],
          [-1, 1, 1, 1, -1],
        ], 
    ),
    // 10
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [0, -1, 1, 0, -1],
          [1, 1, -1, 1, 0],
          [1, 1, 1, 1, -1],
          [-1, 1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
    ),
    // 11
    LevelData(
        gridSize: 5,
        start: [
          [0, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, 2],
        ], 
        target: [
          [-1, 0, -1, -1, -1],
          [0, -1, 1, -1, -1],
          [-1, 1, -1, 1, -1],
          [-1, -1, 1, -1, 2],
          [-1, -1, -1, 2, -1],
        ], 
    ),
    // 12
    LevelData(
        gridSize: 5,
        start: [
          [0, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, 2],
        ], 
        target: [
          [0, -1, 0, -1, -1],
          [-1, 0, 1, 1, -1],
          [0, 1, 1, 2, 2],
          [-1, 1, 2, -1, 2],
          [-1, -1, 2, 2, 2],
        ], 
    ),
    // 13
    LevelData(
        gridSize: 5,
        start: [
          [0, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, 2],
        ], 
        target: [
          [0, 0, 0, -1, -1],
          [0, -1, 0, 1, -1],
          [0, 0, -1, 2, 2],
          [-1, 1, 2, -1, 2],
          [-1, -1, 2, 2, 2],
        ], 
    ),
    // 14
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 2, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, 0, 0, -1],
          [-1, 2, 0, -1, 0],
          [2, -1, 2, 1, -1],
          [-1, 2, 1, -1, 1],
          [-1, -1, 1, 1, -1],
        ], 
    ),
    // 15
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 2, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, 0, -1, 0, -1],
          [-1, 2, 0, 0, -1],
          [2, -1, 2, -1, -1],
          [-1, 2, 1, 1, -1],
          [-1, 1, -1, 1, -1],
        ], 
    ),
    // 16
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 2, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [0, -1, 2, -1, 0],
          [-1, 2, -1, 2, -1],
          [2, -1, 2, -1, 2],
          [-1, 2, -1, 2, -1],
          [1, -1, 2, -1, 1],
        ], 
    ),
    // 17
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, 1, -1],
          [-1, -1, 2, -1, -1],
          [-1, 0, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, 1, -1, 1, -1],
          [1, -1, 1, -1, 1],
          [-1, 0, 2, 1, -1],
          [0, -1, 0, -1, 0],
          [-1, 0, -1, 0, -1],
        ], 
    ),
    // 18
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, 1, -1],
          [-1, -1, 2, -1, -1],
          [-1, 0, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, 1, -1, 1],
          [-1, 2, 2, 1, -1],
          [0, 2, -1, 2, 1],
          [-1, 0, 2, 2, -1],
          [0, -1, 0, -1, -1],
        ], 
    ),
  ];

  static List<LevelData> templates = [
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
    ),
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
    ),
    LevelData(
        gridSize: 5,
        start: [
          [-1, -1, -1, -1, -1],
          [-1, -1, 0, -1, -1],
          [-1, 2, -1, -1, -1],
          [-1, -1, 1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
        target: [
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1],
        ], 
    ),
  ];

  static LevelData loadLevel(int level) {
    return levels[level];
  }

  static LevelData randomLevel(int gridSize) {
    LevelData level = LevelData(
        gridSize: gridSize,
        start: List.generate(gridSize, (i) {
          return List.generate(gridSize, (i) {
            return -1;
          });
        }),
        target: List.generate(gridSize, (i) {
          return List.generate(gridSize, (i) {
            return -1;
          });
        })
    );

    Random rand = Random();
    int numStarting = rand.nextInt(GameColors.tileColors.length)+1;
    numStarting = 5;
    for (int i = 0; i < numStarting; i++) {
      int x = rand.nextInt(gridSize-2)+1;
      int y = rand.nextInt(gridSize-2)+1;
      bool neighborHasTile() {
        bool ret = false;
        if (x+1 < gridSize && level.start[y][x+1] != -1) {
          ret = true;
        }
        if (y+1 < gridSize && level.start[y+1][x] != -1) {
          ret = true;
        }
        if (x-1 >= 0 && level.start[y][x-1] != -1) {
          ret = true;
        }
        if (y-1 >= 0 && level.start[y-1][x] != -1) {
          ret = true;
        }
        return ret;
      }
      while (level.start[y][x] != -1 || neighborHasTile()) {
        x = rand.nextInt(gridSize-2)+1;
        y = rand.nextInt(gridSize-2)+1;
      }
      level.start[y][x] = i;
    }

    print("random level start:");
    level.start.sublist(0, level.start.length).forEach((row) {
      List<int> pr = row.sublist(0, row.length).map( (tile) {return tile;} ).toList();
      print("$pr,");
    });

    return level;
  }

  static LevelData randomFlips(LevelData level, int numFlips) {
    List<List<int>> activeTiles = [];
    for (int y = 0; y < level.gridSize; y++) {
      for (int x = 0; x < level.gridSize; x++) {
        if (level.start[y][x] != -1) {
          level.target[y][x] = level.start[y][x];
          activeTiles.add([x,y]);
        }
      }
    }

    Random rand = Random();
    for (int i = 0; i < numFlips; i++) {
      // choose random tile
      int tile;
      if (rand.nextInt(100) < 80) {
        tile = rand.nextInt((activeTiles.length/5).ceil());
      } else {
        tile = rand.nextInt(activeTiles.length);
      }
      int x = activeTiles[tile][0];
      int y = activeTiles[tile][1];
      int tileColor = level.target[y][x];
      // flip the tile
      activeTiles.removeAt(tile);
      level.target[y][x] = -1;
      if (x+1 < level.gridSize) {
        level.target[y][x+1] = tileColor;
        activeTiles.add([x+1,y]);
      }
      if (y+1 < level.gridSize) {
        level.target[y+1][x] = tileColor;
        activeTiles.add([x,y+1]);
      }
      if (x-1 >= 0) {
        level.target[y][x-1] = tileColor;
        activeTiles.add([x-1,y]);
      }
      if (y-1 >= 0) {
        level.target[y-1][x] = tileColor;
        activeTiles.add([x,y-1]);
      }
    }

    return level;
  }

  static LevelData loadTemplate(int template) {
    if (template < 0) {
      return randomLevel(-1*template);
    } else {
      return templates[template];
    }
  }

  static int maxLevel() {
    return levels.length - 1;
  }

  static int maxTemplate() {
    return templates.length - 1;
  }
}
