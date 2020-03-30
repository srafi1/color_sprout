class LevelData {
  int gridSize;
  List<List<int>> start;
  List<List<int>> target;
  LevelData({this.gridSize, this.start, this.target});
}

class Levels {
  static List<LevelData> levels = [
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
    LevelData(
        gridSize: 3,
        start: [[-1, -1, -1], [-1, 0, -1], [-1, -1, -1]], 
        target: [[-1, 0, -1], [0, -1, 0], [-1, 0, -1]],
    ),
  ];

  static LevelData loadLevel(int level) {
    return levels[level];
  }
}
