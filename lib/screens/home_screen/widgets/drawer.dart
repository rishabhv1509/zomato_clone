import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/constants/images.dart';
import 'package:zomato_clone/utils/constants/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class HomeScreenDrawer extends StatelessWidget {
  final Users user;

  HomeScreenDrawer({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(80),
                            ),
                            border: Border.all(color: Colors.transparent),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  user.profilePricture),
                            ),
                            color: Colors.transparent),
                        child: Container())
                  ],
                ),
                SizedBox(
                  height: 15 * ThemesData.heightRatio,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(user.firstName),
                    SizedBox(
                      height: 15 * ThemesData.heightRatio,
                    ),
                    Text(user.lastName),
                  ],
                ),
                SizedBox(
                  height: 15 * ThemesData.heightRatio,
                ),
                Text(user.email)
              ],
            ),
          ),
          ListTile(
            leading: Image.asset(
              AssetImages.LOGOUT,
              height: 24 * ThemesData.heightRatio,
              width: 24 * ThemesData.widthRatio,
            ),
            title: Text(AppStrings.LOGOUT),
            onTap: () {
              AuthenticationService _auth = AuthenticationService();
              _auth.signOut().whenComplete(() {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.SIGN_IN_SCREEN,
                  (Route<dynamic> route) => false,
                );
              });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.update,
              size: 24 * ThemesData.heightRatio,
              color: Colors.black,
            ),
            title: Text(AppStrings.UPDATE_USER_INFO),
            onTap: () {
              Navigator.pushNamed(context, RouteNames.UPDATE_USER_INFO,
                  arguments: user);
            },
          )
        ],
      ),
    );
  }
}
