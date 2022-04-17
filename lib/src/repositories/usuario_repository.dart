import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> alterarNomeUsuario(String userUID, String nomeUsuario) =>
      _firestore.collection("usuarios").doc(userUID).set(
          {'nome': nomeUsuario, 'timestamp': FieldValue.serverTimestamp()});

  Stream<DocumentSnapshot> obterUsuario(String userUID) =>
      _firestore.collection("usuarios").doc(userUID).snapshots();
}
