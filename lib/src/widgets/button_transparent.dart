import 'package:flutter/material.dart';

class ButtonTransparent extends StatelessWidget {
  final String text;
  final double marginLeft;
  final double marginRight;
  final double height;
  final double fontSize;
  final Color borderColor;
  final Color textColor;
  final VoidCallback callback;
  final double? width;

  const ButtonTransparent({
    required this.text,
    required this.marginLeft,
    required this.marginRight,
    required this.height,
    required this.fontSize,
    required this.borderColor,
    required this.textColor,
    required this.callback,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(left: marginLeft, right: marginRight),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 1, color: borderColor)),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
