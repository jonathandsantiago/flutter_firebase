import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get onUsuarioLogado => _firebaseAuth.authStateChanges();

  String? get obterUIDUsuarioLogado {
    final User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<User?> obterUruarioLogadoAsync() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<bool> loginPorEmailAsync(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('Nenhum usuário encontrado para esse e-mail.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Senha incorreta.');
      }
      return false;
    } catch (e) {
      debugPrint("Exception (loginPorEmailAsync): Error: " + e.toString());
      return false;
    }
  }

  Future<void> cadastrarAsync(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('O e-mail informado já existe.');
      }
    } catch (e) {
      debugPrint("Exception (cadastrarAsync): Error: " + e.toString());
    }
  }

  Future<void> signOutAsync() async {
    _firebaseAuth.signOut();
  }
}
