import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/scoped_models/home_screen_model.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/screens/login_screen/sign_in_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/get_location.dart';
import 'package:zomato_clone/services/permissions.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUserStatus() async {
    AuthenticationService _authService = AuthenticationService();
    FirebaseUser user = await _authService.getCurrentUser();
    location = await HomeScreenModel().getCurrentLocation();

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
                    location: location,
                  )));
    }
  }

  String location;
  @override
  void initState() {
    Permissions permissions = Permissions();
    permissions.getLocationPermission();
    // LocationService().getLocation();
    // getResturantlist('Bengaluru');

    checkUserStatus();
    super.initState();
  }

  String zomatoApiKey = 'e5964034a6f69322e3ccefb373ec72a6';

  // getResturantlist(String location) async {
  //   String url = 'https://developers.zomato.com/api/v2.1/search?entity_id=';
  //   var returantList =
  //       await http.get(url + location, headers: {'user-key': zomatoApiKey});
  //   print('resturant list======>${returantList.body}');
  //   // notifyListeners();
  // }

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
