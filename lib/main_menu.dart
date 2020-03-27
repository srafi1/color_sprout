import "package:color_sprout/game_controller.dart";
import "package:flutter/material.dart";

class MainMenu {
  final GameController gc;
  int level;
  TextPainter titlePainter;
  Offset titleOffset;
  TextPainter startPainter;
  Offset startOffset;
  TextPainter levelsPainter;
  Offset levelsOffset;
  TextPainter ratePainter;
  Offset rateOffset;
  RoundedRectangleBorder r;

  MainMenu(this.gc) {
    level = gc.storage.getInt("level") ?? 0;

    // title
    titlePainter = TextPainter(
      text: TextSpan(
        text: "Color Sprout",
        style: TextStyle(
          color: Colors.black,
          fontSize: gc.baseTextSize * 1.5,
        )
        ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout();
    titleOffset = Offset(
      gc.screenSize.width / 2 - titlePainter.width / 2,
      gc.screenSize.height / 2 - 1.5 * titlePainter.height,
    );

    // start
    startPainter = TextPainter(
      text: TextSpan(
        text: level > 0 ? "Continue: Level $level" : "Start",
        style: TextStyle(
          color: Colors.black,
          fontSize: gc.baseTextSize,
        )
        ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    startPainter.layout();
    startOffset = Offset(
      gc.screenSize.width / 2 - startPainter.width / 2,
      gc.screenSize.height / 2 - startPainter.height / 2,
    );
    r = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(width: 1, color: Colors.black),
    );

    // levels
    levelsPainter = TextPainter(
      text: TextSpan(
        text: "Levels",
        style: TextStyle(
          color: Colors.black,
          fontSize: gc.baseTextSize,
        )
        ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    levelsPainter.layout();
    levelsOffset = Offset(
      gc.screenSize.width / 2 - levelsPainter.width / 2,
      gc.screenSize.height / 2 + 0.5 * levelsPainter.height,
    );

    // rate
    ratePainter = TextPainter(
      text: TextSpan(
        text: "Rate",
        style: TextStyle(
          color: Colors.black,
          fontSize: gc.baseTextSize,
        )
        ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    ratePainter.layout();
    rateOffset = Offset(
      gc.screenSize.width / 2 - ratePainter.width / 2,
      gc.screenSize.height / 2 + 1.5 * ratePainter.height,
    );
  }

  void render(Canvas c) {
    titlePainter.paint(c, titleOffset);
    startPainter.paint(c, startOffset);
    levelsPainter.paint(c, levelsOffset);
    ratePainter.paint(c, rateOffset);
  }
}