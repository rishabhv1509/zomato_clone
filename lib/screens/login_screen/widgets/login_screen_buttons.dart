import 'package:flutter/material.dart';

class LoginScreenButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const LoginScreenButton({Key key, this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: RaisedButton(
        color: Colors.amber,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
