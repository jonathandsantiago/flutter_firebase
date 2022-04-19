import 'package:flutter_firebase/src/repositories/authentication_repository.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationRepository _authRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBody,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Center(
            child: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () => _authRepository.loginPorEmailAsync(
                  'jonathandcsantiago@outlook.com', 'Ab123456.'),
              child: const Text("Sign In"),
            ),
          )
        ],
      ),
    );
  }
}
