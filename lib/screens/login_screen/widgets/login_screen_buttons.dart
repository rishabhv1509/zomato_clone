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
      height: 70 * ThemesData.heightRatio,
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: RaisedButton(
          color: Colors.amber,
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
