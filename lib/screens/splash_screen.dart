import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/models/users.dart';
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
  bool isLoading = true;
  AuthenticationService authService = AuthenticationService();
  Users user;
  void checkUserStatus() async {
    Permissions permissions = Permissions();

    await permissions.getLocationPermission();

    AuthenticationService _authService = AuthenticationService();
    await _authService.getCurrentUser().then((fireBaseUser) {
      if (fireBaseUser == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
            ),
          ),
        );
      }
    });
  }

  getCurrentUser() async {
    FirebaseUser firebaseUser = await authService.getCurrentUser();
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');
    var userData = await usersCollection.document(firebaseUser.uid).get();
    user = Users.fromJson(userData.data);
  }

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  String zomatoApiKey = 'e5964034a6f69322e3ccefb373ec72a6';

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
