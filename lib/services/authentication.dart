import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/services/base_auth.dart';

class AuthenticationService extends BaseAuth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Users user;
  @override
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  @override
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

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
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
    final FirebaseUser firebaseUser = authResult.user;

    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);
    if (firebaseUser != null) {
      final CollectionReference usersCollection =
          Firestore.instance.collection('Users');

      var userData = await usersCollection.document(firebaseUser.uid).get();
      user = Users.fromJson(userData.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: user,
          ),
        ),
      );
    }

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
