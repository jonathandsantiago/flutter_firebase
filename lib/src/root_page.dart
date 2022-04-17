import 'package:flutter_firebase/src/services/usuario_service.dart';
import 'package:flutter_firebase/src/ui/home/home_page.dart';
import 'package:flutter_firebase/src/ui/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  static const String routeName = 'root_page';

  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final UsuarioService _usuarioService = UsuarioService();
  late Stream<User?> _currentUser;

  @override
  void initState() {
    _currentUser = _usuarioService.usuarioLogado;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        return snapshot.hasData ? const HomePage() : const LoginPage();
      },
    );
  }
}
