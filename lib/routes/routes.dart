import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/screens/restaurant_details_screen/restaurant_details_screen.dart';
import 'package:zomato_clone/screens/sign_in_screen/sign_in_screen.dart';
import 'package:zomato_clone/screens/sign_up_screen.dart';
import 'package:zomato_clone/screens/splash_screen.dart';
import 'package:zomato_clone/screens/update_user_info.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case RouteNames.TEST:
      //   return MaterialPageRoute(builder: (_) => TestScreen());
      case RouteNames.SIGN_IN_SCREEN:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case RouteNames.SIGN_UP_SCREEN:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RouteNames.HOME_SCREEN:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            user: settings.arguments,
          ),
        );
      case RouteNames.RESTAURANT_DETAILS_SCREEN:
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailsScreen(
            restaurant: settings.arguments,
          ),
        );
      case RouteNames.UPDATE_USER_INFO:
        return MaterialPageRoute(
          builder: (_) => UpdateUserInfoScrceen(
            user: settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('Error Page'),
            ),
            body: Center(child: Text('Error Page')),
          ),
        );
    }
  }
}
