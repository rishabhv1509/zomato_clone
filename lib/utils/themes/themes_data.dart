import 'package:flutter/material.dart';

class ThemesData {
  static double width;
  static double height;
  static double widthRatio;
  static double heightRatio;
  static const Color PRIMARY_TEXT_COLOR = Colors.black;
  static const Color RATING_TEXT_COLOR = Colors.white;
  static const PRIMARY_COLOR = Colors.amber;

  static setScreenRatio(double width, double height) {
    widthRatio = width / 375;
    heightRatio = height / 667;
  }

  static emailErrorStyle() {
    return TextStyle(fontSize: 12, color: Colors.red);
  }

  static restaurantNameStyle() {
    return TextStyle(
        fontSize: 12 * heightRatio,
        color: PRIMARY_TEXT_COLOR,
        fontFamily: 'Avenir',
        fontWeight: FontWeight.w800);
  }

  static restaurantRatingStyle() {
    return TextStyle(
      fontSize: 10 * heightRatio,
      color: RATING_TEXT_COLOR,
    );
  }

  static signUpPromptStyle() {
    return TextStyle(
      fontSize: 14 * ThemesData.heightRatio,
      color: PRIMARY_COLOR[800],
    );
  }
}
