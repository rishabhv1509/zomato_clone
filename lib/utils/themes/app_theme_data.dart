import 'package:flutter/material.dart';

ThemeData lightTheme;
ThemeData darkTheme;
toggleDark(BuildContext context) {
  return darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.amber,
    accentColor: Colors.amberAccent,
    // textTheme: TextTheme(
    //     title: TextStyle(color: Colors.white),
    //     subtitle: TextStyle(color: Colors.white),
    // subhead: TextStyle(color: Colors.white)),
    textTheme: Theme.of(context)
        .textTheme
        .apply(bodyColor: Colors.white, displayColor: Colors.white),
    appBarTheme: AppBarTheme(color: Colors.amberAccent),
  );
}

toggleWhite(BuildContext context) {
  return lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.brown,
    accentColor: Colors.deepOrangeAccent,
    textTheme: Theme.of(context)
        .textTheme
        .apply(bodyColor: Colors.black, displayColor: Colors.black),
    // textTheme: TextTheme(
    //   title: TextStyle(color: Colors.black),
    //   subtitle: TextStyle(color: Colors.black),
    //   subhead: TextStyle(color: Colors.black),
    // ).apply(bodyColor: Colors.black, displayColor: Colors.black),
    // textTheme:
    // TextTheme(),
    appBarTheme: AppBarTheme(
      color: Colors.green,
    ),
  );
}
