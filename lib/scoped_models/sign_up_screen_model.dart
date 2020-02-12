import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/validation.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/constants/strings.dart';

class SignUpModel extends ChangeNotifier {
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordMatch = true;
  AuthenticationService authService = AuthenticationService();
  Users user;
  final passwordMismatchSnackbar = SnackBar(
    content: Text('Passwords do not match, please make sure passwords match'),
    duration: Duration(seconds: 2),
  );
  final userNameIsEmptySnackBar = SnackBar(
    content: Text('Username or Password is emtpty please check and try again'),
    duration: Duration(seconds: 2),
  );
  final userAlreadyExistsSnackBar = SnackBar(
    content: Text('Email already exists, please Sign In'),
    duration: Duration(seconds: 2),
  );
  final badlyFormattedEmail = SnackBar(
    content: Text('Email is badly formatted, please check your email'),
    duration: Duration(seconds: 2),
  );
  validateEmail(String email) {
    isEmailValid = Validation().emailValidation(email);
    notifyListeners();
  }

  validatePassword(String password) {
    isPasswordValid = Validation().passwordValidation(password);
    notifyListeners();
  }

  checkPasswords(String password, String confirmPassword) {
    if (password == confirmPassword) {
      isPasswordMatch = true;
    } else {
      isPasswordMatch = false;
    }
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

  signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String phoneNumber,
      GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context) {
    if (isPasswordMatch) {
      authService
          .signUp(email, password, firstName, lastName, phoneNumber)
          .then((onValue) async {
        if (onValue == AppStrings.USER_ALREADY_EXISTS) {
          _scaffoldKey.currentState.showSnackBar(userAlreadyExistsSnackBar);
        } else if (onValue == AppStrings.STRING_IS_EMPTY_OR_NULL) {
          _scaffoldKey.currentState.showSnackBar(userNameIsEmptySnackBar);
        } else if (onValue == AppStrings.EMAIL_IS_BADLY_FORMATTED) {
          _scaffoldKey.currentState.showSnackBar(badlyFormattedEmail);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteNames.HOME_SCREEN, (Route<dynamic> route) => false,
              arguments: user);
        }
      });
    }
    notifyListeners();
  }
}
