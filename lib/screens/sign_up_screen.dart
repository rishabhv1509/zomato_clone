import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zomato_clone/scoped_models/sign_up_screen_model.dart';
import 'package:zomato_clone/screens/login_screen/widgets/login_screen_buttons.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/images.dart';
import 'package:zomato_clone/utils/strings.dart';
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
                    controller: firstNameController,
                    hint: 'First Name',
                    image: AssetImages.NAME,
                    isObscured: false,
                    isPassword: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputFileds(
                    controller: lastNameController,
                    hint: 'Last Name',
                    image: AssetImages.NAME,
                    isObscured: false,
                    isPassword: false,
                  ),
                  SizedBox(
                    height: 20,
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
                    controller: phoneNumberController,
                    hint: 'Phone Number',
                    isPhone: true,
                    image: AssetImages.PHONE,
                    isObscured: false,
                    isPassword: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputFileds(
                    controller: passwordController,
                    onChanged: (password) {
                      model.validatePassword(password);
                    },
                    hint: 'Password',
                    image: AssetImages.PASSWORD,
                    isObscured: true,
                    isPassword: true,
                    eye: AssetImages.EYE,
                  ),
                  (!model.isPasswordValid)
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  (!model.isPasswordValid)
                      ? Text(
                          'Password is weak, password should be at least 6 characters long',
                          style: TextStyle(color: Colors.amber),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  InputFileds(
                    onChanged: (confirmPassword) {
                      model.checkPasswords(
                          passwordController.text, confirmPassword);
                    },
                    controller: confirmPasswordController,
                    hint: 'Confirm Password',
                    image: AssetImages.PASSWORD,
                    isObscured: true,
                    isPassword: true,
                    eye: AssetImages.EYE,
                  ),
                  (!model.isPasswordMatch) ? SizedBox(height: 10) : Container(),
                  (!model.isPasswordMatch)
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
        );
      }),
    );
  }
}
