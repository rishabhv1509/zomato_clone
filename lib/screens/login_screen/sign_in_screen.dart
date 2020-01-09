import 'package:flutter/material.dart';
import 'package:zomato_clone/screens/home_page.dart';
import 'package:zomato_clone/screens/login_screen/widgets/login_screen_buttons.dart';
import 'package:zomato_clone/screens/sign_up_screen.dart';
import 'package:zomato_clone/services/authentication.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/images.dart';
import 'package:zomato_clone/utils/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';
import 'package:zomato_clone/widgets/input_fields.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final invalidUserSnackBar = SnackBar(
    content: Text('Invalid UserName, please enter a valid username'),
    duration: Duration(seconds: 2),
  );
  final userNameIsEmptySnackBar = SnackBar(
    content: Text('Username or Password is emtpty please check and try again'),
    duration: Duration(seconds: 2),
  );
  final wrongPasswordSnackBar = SnackBar(
    content: Text('Wrong Password, Plese check your password'),
    duration: Duration(seconds: 2),
  );
  final userNotFoundSnackBar = SnackBar(
    content: Text('User not found, Please check your username'),
    duration: Duration(seconds: 2),
  );
  bool isInvalid = true;
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
                hint: 'Password',
                image: AssetImages.PASSWORD,
                isObscured: true,
                isPassword: true,
                eye: AssetImages.EYE,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Text('Forgot Password'),
                    onTap: () {},
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: LoginScreenButton(
                      label: AppStrings.SIGN_IN,
                      onPressed: (isInvalid ||
                              userNameController.text.isEmpty ||
                              passwordController.text.isEmpty)
                          ? loginFunction
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _authService.signInWithGoogle();
                },
                child: Center(
                    child: Image.asset(
                  'assets/google_logo.png',
                  height: 50,
                  width: 50,
                )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  'Dont have an account, Sign Up here',
                  style: TextStyle(color: Colors.amber),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  loginFunction() {
    setState(() {
      isInvalid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(userNameController.text);
      _authService
          .signIn(userNameController.text, passwordController.text)
          .then((onValue) {
        print(passwordController.text);
        switch (onValue) {
          case AppStrings.SIGN_IN_INVALID_USER_ERROR:
            _scaffoldKey.currentState.showSnackBar(invalidUserSnackBar);
            break;
          case AppStrings.WRONG_PASSWORD:
            _scaffoldKey.currentState.showSnackBar(wrongPasswordSnackBar);
            break;
          case AppStrings.SIGN_IN_USER_NOT_FOUND_ERROR:
            _scaffoldKey.currentState.showSnackBar(userNotFoundSnackBar);
            break;
          case AppStrings.STRING_IS_EMPTY_OR_NULL:
            _scaffoldKey.currentState.showSnackBar(userNameIsEmptySnackBar);
            break;
          default:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    });
  }
}
