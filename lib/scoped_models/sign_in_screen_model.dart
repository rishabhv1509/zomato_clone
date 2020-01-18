import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/validation.dart';
import 'package:zomato_clone/utils/strings.dart';

class SignInModel extends Model {
  bool isEmailValid = true;
  bool isAuthenticating = false;
  AuthenticationService authService = AuthenticationService();
  Users user;
  final invalidUserSnackBar = SnackBar(
    content: Text('Invalid UserName, please enter a valid username'),
    duration: Duration(seconds: 2),
  );
  final userNameIsEmptySnackBar = SnackBar(
    content: Text('Username or Password is empty please check and try again'),
    duration: Duration(seconds: 2),
  );
  final wrongPasswordSnackBar = SnackBar(
    content: Text('Wrong Password, Plese check your password'),
    duration: Duration(seconds: 2),
  );
  final userNotFoundSnackBar = SnackBar(
    content: Text('User not found, Please check your username or Sign Up'),
    duration: Duration(seconds: 2),
  );
  final tooManyRequestsSnackBar = SnackBar(
    content:
        Text('Too many requests please wait for some time and try again later'),
    duration: Duration(seconds: 2),
  );
  validateEmail(String email) {
    isEmailValid = Validation().emailValidation(email);
    notifyListeners();
  }

  getCurrentUser() async {
    FirebaseUser firebaseUser = await authService.getCurrentUser();
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');
    var userData = await usersCollection.document(firebaseUser.uid).get();
    user = Users.fromJson(userData.data);
    notifyListeners();
  }

  signIn(String email, String password, GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context) {
    isAuthenticating = true;
    authService.signIn(email, password).then((onValue) async {
      if (onValue == AppStrings.SIGN_IN_INVALID_USER_ERROR) {
        _scaffoldKey.currentState.showSnackBar(invalidUserSnackBar);
        isAuthenticating = false;
        notifyListeners();
      } else if (onValue == AppStrings.WRONG_PASSWORD) {
        _scaffoldKey.currentState.showSnackBar(wrongPasswordSnackBar);
        isAuthenticating = false;
        notifyListeners();
      } else if (onValue == AppStrings.SIGN_IN_USER_NOT_FOUND_ERROR) {
        _scaffoldKey.currentState.showSnackBar(userNotFoundSnackBar);
        isAuthenticating = false;
        notifyListeners();
      } else if (onValue == AppStrings.STRING_IS_EMPTY_OR_NULL) {
        _scaffoldKey.currentState.showSnackBar(userNameIsEmptySnackBar);
        isAuthenticating = false;
        notifyListeners();
      } else if (onValue == AppStrings.TOO_MANY_REQUESTS) {
        _scaffoldKey.currentState.showSnackBar(tooManyRequestsSnackBar);
        isAuthenticating = false;
        notifyListeners();
      } else {
        isAuthenticating = false;
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
    notifyListeners();
  }

  signInWithGoogle(BuildContext context) async {
    isAuthenticating = true;
    await authService.signInWithGoogle(context);
    FirebaseUser user = await authService.getCurrentUser();
    final CollectionReference usersCollection =
        Firestore.instance.collection('Users');
    await usersCollection.document(user.uid).setData({
      'email_id': user.email,
      'first_name': user.displayName,
      'profile_picture': user.photoUrl
    });
    isAuthenticating = false;
    notifyListeners();
  }
}

SignInModel signInModel = SignInModel();
