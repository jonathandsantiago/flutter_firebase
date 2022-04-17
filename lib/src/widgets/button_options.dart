import 'package:flutter/material.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';

class ButtonOptions extends StatelessWidget {
  final IconData icon;
  final String text;

  const ButtonOptions({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: ColorConstant.colorMain,
          size: 16.0,
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          text,
          style: const TextStyle(
              color: ColorConstant.colorMain,
              fontWeight: FontWeight.w400,
              fontSize: 16.0),
        ),
        const Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              color: ColorConstant.colorMain,
              size: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
