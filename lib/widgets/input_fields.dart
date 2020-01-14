import 'package:flutter/material.dart';
import 'package:zomato_clone/utils/custom_colors.dart';
import 'package:zomato_clone/utils/themes/themes_data.dart';

class InputFileds extends StatefulWidget {
  final String hint;
  final String image;
  final bool isObscured;
  final String eye;
  final bool isPassword;
  final Function(String) onChanged;
  final TextEditingController controller;

  InputFileds(
      {Key key,
      this.hint,
      this.image,
      this.controller,
      this.onChanged,
      this.eye,
      this.isPassword = false,
      this.isObscured = false})
      : super(key: key);

  @override
  _InputFiledsState createState() => _InputFiledsState();
}

class _InputFiledsState extends State<InputFileds> {
  bool showPassword;
  @override
  void initState() {
    showPassword = widget.isObscured;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50 * ThemesData.heightRatio,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.INPUT_FIELD_COLOR),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: CustomColors.INPUT_FIELD_COLOR),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: widget.onChanged,
              style: TextStyle(color: Colors.black),
              controller: widget.controller,
              obscureText: showPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                // fillColor: CustomColors.INPUT_FIELD_COLOR,
                hintText: widget.hint,
                icon: Image.asset(
                  widget.image,
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          (widget.isPassword)
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Container(
                    child: (Image.asset(
                      widget.eye,
                      width: 24,
                      height: 24,
                    )),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
