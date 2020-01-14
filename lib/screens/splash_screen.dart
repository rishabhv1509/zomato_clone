import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/screens/login_screen/sign_in_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/permissions.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUserStatus() async {
    AuthenticationService _authService = AuthenticationService();
    FirebaseUser user = await _authService.getCurrentUser();
    print('user=====>$user');
    if (user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    user: user,
                  )));
    }
  }

  @override
  void initState() {
    Permissions permissions = Permissions();
    permissions.getLocationPermission();
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemesData.height = MediaQuery.of(context).size.height;
    ThemesData.width = MediaQuery.of(context).size.width;
    ThemesData.setScreenRatio(ThemesData.width, ThemesData.height);
    return FlareActor("assets/animation.flr",
        alignment: Alignment.center,
        sizeFromArtboard: true,
        fit: BoxFit.contain,
        animation: "Untitled");
  }
}
