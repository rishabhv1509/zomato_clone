import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Users user;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<String> signIn(String userName, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: userName, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<String> signUp(String email, String password, String firstName,
      String lastName, String phoneNumber) async {
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await usersCollection.document(user.uid).setData({
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'email_id': email,
        'phone_no': phoneNumber,
        'profile_picture': ''
      });

      return user.uid;
    } catch (error) {
      return error.toString();
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser fbuser = authResult.user;
    if (fbuser != null) {
      final CollectionReference usersCollection =
          Firestore.instance.collection('Users');
      await usersCollection.document(fbuser.uid).setData({
        'first_name': fbuser.displayName,
        'email_id': fbuser.email,
        'profile_picture': fbuser.photoUrl
      });
      var userData = await usersCollection.document(fbuser.uid).get();
      user = Users.fromJson(userData.data);
      print(user.email);
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.HOME_SCREEN, (Route<dynamic> route) => false,
          arguments: user);
    }

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
