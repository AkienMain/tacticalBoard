import 'package:flutter/material.dart';

class PartsWidget {
  static markerContainer(
      String text, Color markerColor, double dia, double fontSize) {
    return Container(
      width: dia * 2,
      height: dia * 2,
      decoration: BoxDecoration(
        color: const Color(0x04000000),
        borderRadius: BorderRadius.circular(dia),
      ),
      alignment: Alignment.center,
      child: Container(
        width: dia,
        height: dia,
        decoration: BoxDecoration(
          color: markerColor,
          borderRadius: BorderRadius.circular(dia / 2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static ballContainer(Color ballColor, double dia) {
    return Container(
      width: dia * 2,
      height: dia * 2,
      decoration: BoxDecoration(
        color: const Color(0x04000000),
        borderRadius: BorderRadius.circular(dia),
      ),
      alignment: Alignment.center,
      child: Container(
        width: dia,
        height: dia,
        decoration: BoxDecoration(
          color: ballColor,
          borderRadius: BorderRadius.circular(dia / 2),
        ),
      ),
    );
  }

  static textContainer(String text, double fontSize, double margin) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Text(text,
          style: TextStyle(
            fontSize: fontSize,
          )),
    );
  }
}

class Marker {
  // Private Member
  Offset pos;
  int number;

  // Constructor
  Marker(this.pos, this.number);
}

class Ball {
  // Private Member
  Offset pos;

  // Constructor
  Ball(this.pos);
}

class StaticVars {
  static const int minPlayerNum = 0;
  static const int maxPlayerNum = 15;

  static List<int> playerNums = [minPlayerNum, minPlayerNum];
  static List<Color> colors = [Colors.blue, Colors.grey];
  static List<List<int>> uniformNums = [[], []];
  static List<List<List<double>>> posRates = [[], []];
  static List<List<Marker>> markers = [[], []];
  static Ball ball = Ball(const Offset(150, 300));

  static late String state;
  static late Size windowSize;

  StaticVars() {
    setStaticVars();
  }

  static setStaticVars() {
    for (int team = 0; team < playerNums.length; team++) {
      for (int player = 0; player < maxPlayerNum; player++) {
        uniformNums[team].add(player + 1);
        posRates[team].add([
          team / (playerNums.length - 1) * 0.6 + 0.2,
          player / (maxPlayerNum - 1) * 0.6 + 0.2
        ]);

        if (StaticVars.windowSize.width != 0) {
          markers[team].add(Marker(
              Offset(posRates[team][player][0] * StaticVars.windowSize.width,
                  posRates[team][player][1] * StaticVars.windowSize.height),
              uniformNums[team][player]));
          ball = Ball(Offset(0.5 * StaticVars.windowSize.width,
              0.5 * StaticVars.windowSize.height));
        }
        // In the case windowSize cannot be get
        else {
          markers[team].add(Marker(
              Offset(posRates[team][player][0] * 300,
                  posRates[team][player][1] * 600),
              uniformNums[team][player]));
          ball = Ball(const Offset(150, 300));
        }
      }
    }
  }
}
