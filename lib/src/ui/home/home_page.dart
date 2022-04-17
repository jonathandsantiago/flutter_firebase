import 'package:flutter_firebase/src/ui/home/home_content.dart';
import 'package:flutter_firebase/src/ui/home/home_header.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePagePageState createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBody,
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Column(children: const <Widget>[HomeHeader()]),
        const HomeContent()
      ]),
    );
  }
}
