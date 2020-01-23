import 'package:flutter/material.dart';

class ThemesData {
  static double width;
  static double height;
  static double widthRatio;
  static double heightRatio;
  static const Color PRIMARY_TEXT_COLOR = Colors.black;
  static const Color RATING_TEXT_COLOR = Colors.white;
  static const Color REVIEW_COLOR = Colors.grey;
  static const PRIMARY_COLOR = Colors.amber;
  // static const DEFAULT_

  static setScreenRatio(double width, double height) {
    widthRatio = width / 375;
    heightRatio = height / 667;
  }

  static emailErrorStyle() {
    return TextStyle(fontSize: 12 * heightRatio, color: Colors.red);
  }

  static homeScreenHeadingStyle() {
    return TextStyle(
        fontSize: 14 * heightRatio,
        color: PRIMARY_TEXT_COLOR,
        fontWeight: FontWeight.bold);
  }

  static restaurantNameStyle() {
    return TextStyle(
        fontSize: 12 * heightRatio,
        color: PRIMARY_TEXT_COLOR,
        fontWeight: FontWeight.bold);
  }

  static restaurantCuisineStyle() {
    return TextStyle(
        fontSize: 12 * heightRatio,
        color: PRIMARY_TEXT_COLOR,
        fontWeight: FontWeight.normal);
  }

  static restaurantCostStyle() {
    return TextStyle(
        fontSize: 12 * heightRatio,
        color: PRIMARY_TEXT_COLOR,
        fontWeight: FontWeight.normal);
  }

  static restaurantRatingStyle() {
    return TextStyle(
      fontSize: 10 * heightRatio,
      color: RATING_TEXT_COLOR,
    );
  }

  static restaurantReviewCountStyle() {
    return TextStyle(
      fontSize: 7 * heightRatio,
      color: Colors.black,
    );
  }

  static restaurantReviewTextStyle() {
    return TextStyle(
      fontSize: 7 * heightRatio,
      color: REVIEW_COLOR,
    );
  }

  static signUpPromptStyle() {
    return TextStyle(
      fontSize: 14 * ThemesData.heightRatio,
      color: PRIMARY_COLOR[800],
    );
  }
}

//  elevation: 20,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
