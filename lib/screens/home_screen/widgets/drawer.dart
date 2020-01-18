import 'package:flutter/material.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/screens/login_screen/sign_in_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/utils/images.dart';
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
                    CircleAvatar(
                      maxRadius: 20 * ThemesData.heightRatio,
                      child: Image.network(user.profilePricture),
                    )
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
            title: Text('Logout'),
            onTap: () {
              AuthenticationService _auth = AuthenticationService();
              _auth.signOut().whenComplete(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
          )
        ],
      ),
    );
  }
}
