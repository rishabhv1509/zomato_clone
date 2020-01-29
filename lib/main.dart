import 'package:flutter/material.dart';
import 'package:zomato_clone/routes/routes.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/custom_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomColors customColors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Montserrat'),
      initialRoute: RouteNames.SPLASH_SCREEN,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
