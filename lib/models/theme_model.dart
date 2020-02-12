import 'package:flutter/material.dart';

enum ThemeType { Dark, Light, Red, Blue }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme;
  ThemeType themeType = ThemeType.Dark;

  toggleTheme(BuildContext context) {
    if (themeType == ThemeType.Dark) {
      print('inDark');
      currentTheme = ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        appBarTheme: AppBarTheme(color: Colors.amberAccent),
      );
      themeType = ThemeType.Light;
      notifyListeners();
    } else if (themeType == ThemeType.Light) {
      print('in light');

      currentTheme = ThemeData.light().copyWith(
        primaryColor: Colors.amber,
        accentColor: Colors.amberAccent,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
        appBarTheme: AppBarTheme(color: Colors.amberAccent),
      );
      // themeType = ThemeType.Dark;
      notifyListeners();
      themeType = ThemeType.Dark;
      // print(themeType);
    }
    print('toggle 2$themeType');
    notifyListeners();
    return currentTheme;
  }
}
