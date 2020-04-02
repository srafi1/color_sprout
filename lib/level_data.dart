class LevelData {
  int gridSize;
  List<List<int>> start;
  List<List<int>> target;
  LevelData({this.gridSize, this.start, this.target});
}

class Levels {
  static List<LevelData> levels = [
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

  static LevelData loadLevel(int level) {
    return levels[level];
  }

  static int maxLevel() {
    return levels.length - 1;
  }
}
