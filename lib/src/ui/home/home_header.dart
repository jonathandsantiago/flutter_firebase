import 'package:flutter_firebase/src/ui/home/home_avatar.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        HomeAvatar(),
        Container(
            height: 30.0,
            margin: const EdgeInsets.only(top: 50.0, bottom: 5),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: ColorConstant.colorMain,
            )),
      ],
    );
  }
}
