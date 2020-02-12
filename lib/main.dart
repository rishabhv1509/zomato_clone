import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomato_clone/models/theme_model.dart';
import 'package:zomato_clone/routes/routes.dart';
import 'package:zomato_clone/scoped_models/home_screen_model.dart';
import 'package:zomato_clone/scoped_models/restaurant_details_screen_model.dart';
import 'package:zomato_clone/scoped_models/sign_in_screen_model.dart';
import 'package:zomato_clone/scoped_models/sign_up_screen_model.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/custom_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomColors customColors = CustomColors();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeScreenModel>(
          create: (BuildContext context) => HomeScreenModel(),
        ),
        ChangeNotifierProvider<ThemeModel>(
          create: (BuildContext context) => ThemeModel(),
        ),
        ChangeNotifierProvider<SignInModel>(create: (c) => SignInModel()),
        ChangeNotifierProvider<SignUpModel>(create: (c) => SignUpModel()),
        ChangeNotifierProvider<RestaurantDetailsScreenModel>(
            create: (c) => RestaurantDetailsScreenModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (BuildContext context, ThemeModel value, Widget child) {
          print('in consumer entry');
          return MaterialApp(
            title: 'Flutter Demo',
            theme: value.currentTheme,
            // theme: ThemeData(primaryColor: Colors.amber),
            initialRoute: RouteNames.SPLASH_SCREEN,
            onGenerateRoute: Routes.generateRoutes,
          );
        },
      ),
    );
  }
}
