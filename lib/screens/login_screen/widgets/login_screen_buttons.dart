import 'package:flutter/material.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class LoginScreenButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const LoginScreenButton({Key key, this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75 * ThemesData.heightRatio,
      padding: EdgeInsets.all(10 * ThemesData.heightRatio),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(30 * ThemesData.heightRatio),
        ),
        child: RaisedButton(
          color: ThemesData.PRIMARY_COLOR,
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(fontSize: 15 * ThemesData.heightRatio),
          ),
        ),
      ),
    );
  }
}
