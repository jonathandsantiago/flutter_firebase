import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/models/usuario_model.dart';
import 'package:flutter_firebase/src/services/usuario_service.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAvatar extends StatelessWidget {
  final UsuarioService _usuarioService = UsuarioService();

  HomeAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usuarioService.usuarioLogado,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          String? uid = user?.uid;

          if (uid != null) {
            return SizedBox(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: _usuarioService.obterUsuario(uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UsuarioModel usuarioModel =
                          UsuarioModel.fromDocument(snapshot.data);

                      return Container(
                        height: 20,
                        margin: const EdgeInsets.only(top: 40.0, left: 10.0),
                        alignment: Alignment.center,
                        child: Text(
                          usuarioModel.nome,
                          style: const TextStyle(
                              color: ColorConstant.colorMain,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
