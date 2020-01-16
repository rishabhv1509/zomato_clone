import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/models/users.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/services/validation.dart';
import 'package:zomato_clone/utils/strings.dart';

class SignUpModel extends Model {
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordMatch = true;
  AuthenticationService authService = AuthenticationService();
  Users user;
  final passwordMismatchSnackbar = SnackBar(
    content: Text('Password do not match, please make sure passwords match'),
    duration: Duration(seconds: 2),
  );
  final userNameIsEmptySnackBar = SnackBar(
    content: Text('Username or Password is emtpty please check and try again'),
    duration: Duration(seconds: 2),
  );
  final userAlreadyExistsSnackBar = SnackBar(
    content: Text('Email alredy exists, please Sign In'),
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
        // FirebaseUser user = await authService.getCurrentUser();
        if (onValue == AppStrings.USER_ALREADY_EXISTS) {
          _scaffoldKey.currentState.showSnackBar(userAlreadyExistsSnackBar);
        } else if (onValue == AppStrings.STRING_IS_EMPTY_OR_NULL) {
          _scaffoldKey.currentState.showSnackBar(userNameIsEmptySnackBar);
        } else if (onValue == AppStrings.EMAIL_IS_BADLY_FORMATTED) {
          _scaffoldKey.currentState.showSnackBar(badlyFormattedEmail);
        } else {
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
    }
    notifyListeners();
  }
}

SignUpModel signUpModel = SignUpModel();
