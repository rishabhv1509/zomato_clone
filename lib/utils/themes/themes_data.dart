import 'package:flutter/material.dart';

class ThemesData {
  static double width;
  static double height;
  static double widthRatio;
  static double heightRatio;

  static setScreenRatio(double width, double height) {
    widthRatio = width / 375;
    heightRatio = height / 667;
  }

  static emailErrorStyle() {
    return TextStyle(fontSize: 12, color: Colors.red);
  }
}
