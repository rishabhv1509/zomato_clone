import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/scoped_models/sign_in_screen_model.dart';
import 'package:zomato_clone/screens/sign_in_screen/widgets/login_screen_buttons.dart';
import 'package:zomato_clone/utils/constants/images.dart';
import 'package:zomato_clone/utils/constants/route_names.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/constants/strings.dart';
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      0.5,
                      0.7,
                      0.9
                    ],
                    colors: [
                      Colors.amber[800],
                      Colors.amber[700],
                      Colors.amber[600],
                      Colors.amber[400]
                    ]),
              ),
              padding: EdgeInsets.only(
                  left: 20 * ThemesData.widthRatio,
                  right: 20 * ThemesData.widthRatio,
                  top: 10 * ThemesData.heightRatio,
                  bottom: 100 * ThemesData.heightRatio),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 150 * ThemesData.heightRatio,
                    width: 150 * ThemesData.widthRatio,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset(
                        AssetImages.LOGO,
                        // fit: BoxFit.contain,
                        height: 100 * ThemesData.heightRatio,
                        width: 100 * ThemesData.widthRatio,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50 * ThemesData.heightRatio,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10 * ThemesData.widthRatio,
                          right: 10 * ThemesData.widthRatio,
                          top: 25 * ThemesData.heightRatio,
                          bottom: 15 * ThemesData.heightRatio),
                      child: Column(
                        children: <Widget>[
                          InputFileds(
                            onChanged: (email) {
                              model.validateEmail(email);
                            },
                            controller: userNameController,
                            hint: AppStrings.EMAIL,
                            image: AssetImages.EMAIL,
                            isObscured: false,
                            isPassword: false,
                          ),
                          (!model.isEmailValid)
                              ? SizedBox(
                                  height: 10 * ThemesData.heightRatio,
                                )
                              : Container(),
                          (!model.isEmailValid)
                              ? Text(
                                  AppStrings.EMAIL_VERIFICATION_ERROR,
                                  style: ThemesData.emailErrorStyle(),
                                )
                              : Container(),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          InputFileds(
                            controller: passwordController,
                            hint: AppStrings.PASSWORD,
                            image: AssetImages.PASSWORD,
                            isObscured: true,
                            isPassword: true,
                            eye: AssetImages.EYE,
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              (!model.isAuthenticating)
                                  ? Expanded(
                                      child: LoginScreenButton(
                                        label: AppStrings.SIGN_IN,
                                        onPressed: () {
                                          model.signIn(
                                              userNameController.text,
                                              passwordController.text,
                                              _scaffoldKey,
                                              context);
                                        },
                                      ),
                                    )
                                  : CircularProgressIndicator(),
                            ],
                          ),
                          SizedBox(
                            height: 10 * ThemesData.heightRatio,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                child: Text(AppStrings.FORGOT_PASSWORD),
                                onTap: () {},
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          GestureDetector(
                            onTap: () {
                              model.signInWithGoogle(context, _scaffoldKey);
                            },
                            child: Center(
                                child: Image.asset(
                              AssetImages.LOGO,
                              height: 30 * ThemesData.heightRatio,
                              width: 30 * ThemesData.widthRatio,
                            )),
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.SIGN_UP_SCREEN);
                            },
                            child: Text(
                              AppStrings.SIGN_UP_PROMPT,
                              style: ThemesData.signUpPromptStyle(),
                            ),
                          )
                        ],
                      ),
                    ),
                    elevation: 10 * ThemesData.heightRatio,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
