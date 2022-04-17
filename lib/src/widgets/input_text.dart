import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final TextInputType textInputType;
  final String hintText;
  final bool obscured;
  final void Function(String) onChanged;
  final String? errorText;
  const InputText(
      {required this.obscured,
      required this.marginLeft,
      required this.marginRight,
      required this.marginTop,
      required this.textInputType,
      required this.hintText,
      required this.onChanged,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: marginLeft, right: marginRight, top: marginTop),
      child: TextField(
        key: key,
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: obscured,
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xCC000000)),
              borderRadius: BorderRadius.all(Radius.circular(0))),
          fillColor: Colors.white,
          hintText: hintText,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.colorMain),
          ),
        ),
      ),
    );
  }
}
