import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/scoped_models/sign_in_screen_model.dart';
import 'package:zomato_clone/screens/login_screen/widgets/login_screen_buttons.dart';
import 'package:zomato_clone/screens/sign_up_screen.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/images.dart';
import 'package:zomato_clone/utils/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';
import 'package:zomato_clone/widgets/input_fields.dart';

class SignInScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SignInModel>(
      model: signInModel,
      child:
          ScopedModelDescendant<SignInModel>(builder: (context, child, model) {
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
                        border:
                            Border.all(color: CustomColors.BACKGROUND_COLOR),
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
                    onChanged: (email) {
                      model.validateEmail(email);
                    },
                    controller: userNameController,
                    hint: 'Email',
                    image: AssetImages.EMAIL,
                    isObscured: false,
                    isPassword: false,
                  ),
                  (!model.isEmailValid)
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  (!model.isEmailValid)
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
                          onPressed: () {
                            model.signIn(userNameController.text,
                                passwordController.text, _scaffoldKey, context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      model.signInWithGoogle(context);
                    },
                    child: Center(
                        child: Image.asset(
                      'assets/google_logo.png',
                      height: 30,
                      width: 30,
                    )),
                  ),
                  SizedBox(
                    height: 20,
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
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 14 * ThemesData.heightRatio),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
