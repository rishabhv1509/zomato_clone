import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/home_screen/home_screen.dart';
import 'package:zomato_clone/screens/login_screen/widgets/login_screen_buttons.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/images.dart';
import 'package:zomato_clone/utils/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';
import 'package:zomato_clone/widgets/input_fields.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
  bool isInvalid = true;
  bool passwordMatch = true;
  bool isPasswordWeak = false;
  AuthenticationService _authService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomColors.BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: CustomColors.BACKGROUND_COLOR),
                    shape: BoxShape.circle),
                child: Center(
                  child: Image.asset(
                    AssetImages.LOGO,
                    // fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              InputFileds(
                controller: userNameController,
                hint: 'Email',
                image: AssetImages.EMAIL,
                isObscured: false,
                isPassword: false,
              ),
              (!isInvalid)
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(),
              (!isInvalid)
                  ? Text(
                      AppStrings.EMAIL_VERIFICATION_ERROR,
                      style: ThemesData.emailErrorStyle(),
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              InputFileds(
                controller: passwordController,
                onChanged: (text) {
                  setState(() {
                    if (text.length < 6) {
                      isPasswordWeak = true;
                    } else {
                      isPasswordWeak = false;
                    }
                  });
                },
                hint: 'Password',
                image: AssetImages.PASSWORD,
                isObscured: true,
                isPassword: true,
                eye: AssetImages.EYE,
              ),
              (isPasswordWeak)
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(),
              (isPasswordWeak)
                  ? Text(
                      'Password is weak, password should be at least 6 characters long',
                      style: TextStyle(color: Colors.amber),
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              InputFileds(
                controller: confirmPasswordController,
                hint: 'Confirm Password',
                image: AssetImages.PASSWORD,
                isObscured: true,
                isPassword: true,
                eye: AssetImages.EYE,
              ),
              (!passwordMatch) ? SizedBox(height: 10) : Container(),
              (!passwordMatch)
                  ? Text(
                      'Password do not match',
                      style: TextStyle(color: Colors.amber),
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: LoginScreenButton(
                      label: AppStrings.SIGN_UP,
                      onPressed: signUpFunction,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signUpFunction() {
    setState(() {
      isInvalid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(userNameController.text);
      if (passwordController.text != confirmPasswordController.text) {
        passwordMatch = false;
      } else {
        passwordMatch = true;
      }
      if (passwordMatch) {
        _authService
            .signUp(userNameController.text, passwordController.text)
            .then((onValue) {
          switch (onValue) {
            case AppStrings.USER_ALREADY_EXISTS:
              _scaffoldKey.currentState.showSnackBar(userAlreadyExistsSnackBar);
              break;
            case AppStrings.STRING_IS_EMPTY_OR_NULL:
              _scaffoldKey.currentState.showSnackBar(userNameIsEmptySnackBar);
              break;
            default:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        });
      } else {
        _scaffoldKey.currentState.showSnackBar(passwordMismatchSnackbar);
      }
    });
  }
}
