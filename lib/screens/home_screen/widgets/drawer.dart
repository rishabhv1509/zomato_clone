import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/login_screen/sign_in_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/utils/images.dart';

class HomeScreenDrawer extends StatelessWidget {
  final String profilePicture;
  final String name;
  final String email;

  HomeScreenDrawer({Key key, this.profilePicture, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  child: (profilePicture != null)
                      ? Image.network(profilePicture)
                      : Image.asset('assets/eye.png'),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      (name != null) ? name : 'hello',
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      email,
                      textAlign: TextAlign.left,
                    )
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Image.asset(AssetImages.LOGOUT),
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
