import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/home_screen/widgets/drawer.dart';
import 'package:zomato_clone/screens/login_screen/sign_in_screen.dart';
import 'package:zomato_clone/services/authentication.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen({Key key, this.user}) : super(key: key);
  final _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeScreenDrawer(
        profilePicture:
            (user.photoUrl != null) ? user.photoUrl : 'assets/eye.png',
        email: user.email,
        name: user.displayName,
      ),
      appBar: AppBar(
        title: Text('Zomtao Clone'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
