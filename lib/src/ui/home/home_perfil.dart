import 'package:flutter_firebase/src/services/usuario_service.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:flutter_firebase/src/widgets/button_options.dart';
import 'package:flutter_firebase/src/widgets/button_transparent.dart';
import 'package:flutter/material.dart';

class HomePerfil extends StatelessWidget {
  final UsuarioService _usuarioService = UsuarioService();

  HomePerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(
          color: ColorConstant.colorMain,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const ButtonOptions(
          icon: Icons.help_outline,
          text: "Sobre o App",
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(
          color: ColorConstant.colorMain,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const ButtonOptions(
          icon: Icons.perm_identity,
          text: "Meu Perfil",
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(
          color: ColorConstant.colorMain,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const ButtonOptions(
          icon: Icons.settings,
          text: "Configurações do App",
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(
          color: ColorConstant.colorMain,
        ),
        const SizedBox(
          height: 25,
        ),
        ButtonTransparent(
          callback: () {
            _usuarioService.signOut();
          },
          fontSize: 20.0,
          height: 50,
          marginLeft: 0,
          marginRight: 0,
          text: "SAIR",
          borderColor: ColorConstant.colorMain,
          textColor: ColorConstant.colorMain,
        )
      ],
    );
  }
}
