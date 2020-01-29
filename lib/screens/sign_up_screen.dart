import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/scoped_models/sign_up_screen_model.dart';
import 'package:zomato_clone/screens/sign_in_screen/widgets/login_screen_buttons.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/constants/images.dart';
import 'package:zomato_clone/utils/constants/strings.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';
import 'package:zomato_clone/widgets/input_fields.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<SignUpModel>(
      model: signUpModel,
      child:
          ScopedModelDescendant<SignUpModel>(builder: (context, child, model) {
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
                      // Colors are easy thanks to Flutter's Colors class.
                      Colors.amber[800],
                      Colors.amber[700],
                      Colors.amber[600],
                      Colors.amber[400]
                    ]),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50 * ThemesData.heightRatio,
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
                        Radius.circular(5 * ThemesData.heightRatio),
                      ),
                    ),
                    color: Colors.white,
                    elevation: 10 * ThemesData.heightRatio,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0 * ThemesData.widthRatio,
                          right: 10 * ThemesData.widthRatio,
                          top: 25 * ThemesData.heightRatio,
                          bottom: 15 * ThemesData.heightRatio),
                      child: Column(
                        children: <Widget>[
                          InputFileds(
                            controller: firstNameController,
                            hint: AppStrings.FIRST_NAME,
                            image: AssetImages.NAME,
                            isObscured: false,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          InputFileds(
                            controller: lastNameController,
                            hint: AppStrings.LAST_NAME,
                            image: AssetImages.NAME,
                            isObscured: false,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
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
                            height: 20 * ThemesData.heightRatio,
                          ),
                          InputFileds(
                            controller: phoneNumberController,
                            hint: AppStrings.PHONE_NUMBER,
                            isPhone: true,
                            image: AssetImages.PHONE,
                            isObscured: false,
                            isPassword: false,
                          ),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          InputFileds(
                            controller: passwordController,
                            onChanged: (password) {
                              model.validatePassword(password);
                            },
                            hint: AppStrings.PASSWORD,
                            image: AssetImages.PASSWORD,
                            isObscured: true,
                            isPassword: true,
                            eye: AssetImages.EYE,
                          ),
                          (!model.isPasswordValid)
                              ? SizedBox(
                                  height: 10 * ThemesData.heightRatio,
                                )
                              : Container(),
                          (!model.isPasswordValid)
                              ? Text(
                                  AppStrings.WEAK_PASSWORD,
                                  style: TextStyle(color: Colors.amber),
                                )
                              : Container(),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          InputFileds(
                            onChanged: (confirmPassword) {
                              model.checkPasswords(
                                  passwordController.text, confirmPassword);
                            },
                            controller: confirmPasswordController,
                            hint: AppStrings.CONFIRM_PASSWORD,
                            image: AssetImages.PASSWORD,
                            isObscured: true,
                            isPassword: true,
                            eye: AssetImages.EYE,
                          ),
                          (!model.isPasswordMatch)
                              ? SizedBox(height: 10)
                              : Container(),
                          (!model.isPasswordMatch)
                              ? Text(
                                  AppStrings.PASSWORD_DONT_MATCH,
                                  style: TextStyle(color: Colors.amber),
                                )
                              : Container(),
                          SizedBox(
                            height: 20 * ThemesData.heightRatio,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: LoginScreenButton(
                                    label: AppStrings.SIGN_UP,
                                    onPressed: () {
                                      model.signUp(
                                          userNameController.text,
                                          passwordController.text,
                                          firstNameController.text,
                                          lastNameController.text,
                                          phoneNumberController.text,
                                          _scaffoldKey,
                                          context);
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
