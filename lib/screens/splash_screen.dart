import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/services/permissions.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Permissions permissions = Permissions();
    permissions.getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlareActor("assets/animation.flr",
        alignment: Alignment.center,
        sizeFromArtboard: true,
        fit: BoxFit.contain,
        animation: "Untitled");
  }
}
