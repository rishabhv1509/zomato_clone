import 'package:flutter/material.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/permissions.dart';
import 'package:zomato_clone/utils/constants/images.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool isLoading = true;
  Animation<double> animation;
  Animation<double> animHeight;
  Animation<double> animWidth;
  AnimationController controller1;
  AnimationController controller;

  AuthenticationService authService = AuthenticationService();
  Users user;
  void checkUserStatus() async {
    Permissions permissions = Permissions();

    await permissions.getLocationPermission();

    AuthenticationService _authService = AuthenticationService();

    await _authService.getCurrentUser().then((fireBaseUser) {
      if (fireBaseUser == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.SIGN_IN_SCREEN, (Route<dynamic> route) => false,
            arguments: user);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.HOME_SCREEN, (Route<dynamic> route) => false,
            arguments: user);
      }
    });
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller1 =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    animHeight = Tween<double>(begin: 0, end: 0).animate(controller);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      animHeight = Tween<double>(
              begin: ThemesData.height + 100, end: ThemesData.height / 2)
          .animate(controller)
            ..addListener(() {
              setState(() {});
            });
    });
    animWidth = Tween<double>(begin: 0, end: 0).animate(controller);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      animWidth = Tween<double>(
              begin: ThemesData.width / 2, end: ThemesData.width / 3)
          .chain(CurveTween(curve: Curves.ease))
          .animate(controller)
            ..addListener(() {
              setState(() {});
            })
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                animWidth = Tween<double>(begin: ThemesData.width / 3, end: 0)
                    .animate(controller1)
                      ..addListener(() {
                        setState(() {});
                      });
              }
            });
    });

    controller.forward().whenComplete(() {
      controller1.forward();
    }).whenComplete(() {
      Navigator.pushNamed(context, RouteNames.SIGN_IN_SCREEN);
    });

    checkUserStatus();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemesData.height = MediaQuery.of(context).size.height;
    ThemesData.width = MediaQuery.of(context).size.width;
    ThemesData.setScreenRatio(ThemesData.width, ThemesData.height);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Transform.translate(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage(AssetImages.LOGO),
              ),
            ),
            height: animation.value,
            width: animation.value,
            child: Container(),
          ),
          offset: Offset(animWidth.value, animHeight.value),
        ),
      ),
    );
  }
}
