import 'package:flutter_firebase/src/ui/home/home_page.dart';
import 'package:flutter_firebase/src/ui/login/login_page.dart';
import 'package:flutter/material.dart';

import 'root_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Financeiro",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.purpleAccent)),
      initialRoute: RootPage.routeName,
      routes: {
        RootPage.routeName: (context) => const RootPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
