import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/repositories/authentication_repository.dart';
import 'package:flutter_firebase/src/repositories/usuario_repository.dart';
import 'package:flutter_firebase/src/services/service_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioService implements ServiceBase {
  final AuthenticationRepository _authRepository = AuthenticationRepository();
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  Stream<User?> get usuarioLogado => _authRepository.onUsuarioLogado;

  String? get usuarioLogadoId => _authRepository.obterUIDUsuarioLogado;

  Future<User?> get obterUruarioLogadoAsync =>
      _authRepository.obterUruarioLogadoAsync();

  Future<bool> loginPorEmailAsync(String email, String password) =>
      _authRepository.loginPorEmailAsync(email, password);

  Future<void> cadastrarAsync(String email, String password) =>
      _authRepository.cadastrarAsync(email, password);

  Future<void> signOut() => _authRepository.signOutAsync();

  Future<void> alterarNomeUsuario(String userUID, String nomeUsuario) =>
      _usuarioRepository.alterarNomeUsuario(userUID, nomeUsuario);

  Stream<DocumentSnapshot> obterUsuario(String userUID) =>
      _usuarioRepository.obterUsuario(userUID);

  @override
  void dispose() async {}
}
