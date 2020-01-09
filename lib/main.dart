import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/login_screen/sign_in_screen.dart';
import 'package:zomato_clone/utils/custom_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CustomColors customColors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffED4634, customColors.colors),
      ),
      // primarySwatch: Colors.amber),
      home: SignInScreen(),
    );
  }
}
