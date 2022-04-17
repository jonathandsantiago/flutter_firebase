import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/models/lancamento_model.dart';

class FinanceiroRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> obterLancamentosFinanceiroUsuario(String userUID) =>
      _firestore.collection("financeiros").doc(userUID).snapshots();

  Future<void> lancarConta(
          String userUID, LancamentoOrigem origem, double expenseValue) =>
      _firestore
          .collection("financeiros")
          .doc(userUID)
          .collection("lancamentos")
          .doc()
          .set({
        'valor': expenseValue,
        'origem': origem.index,
        'timestamp': FieldValue.serverTimestamp()
      });

  Stream<QuerySnapshot> obterLancamentos(String userUID) => _firestore
      .collection("financeiros")
      .doc(userUID)
      .collection("lancamentos")
      .orderBy('timestamp', descending: true)
      .snapshots();

  Stream<QuerySnapshot> obterUltimoLancamento(String userUID) => _firestore
      .collection("financeiros")
      .doc(userUID)
      .collection("lancamentos")
      .orderBy('timestamp', descending: true)
      .limit(1)
      .snapshots();

  Future<void> alterarNomeUsuario(String userUID, String nomeUsuario) =>
      _firestore.collection("usuarios").doc(userUID).set(
          {'nome': nomeUsuario, 'timestamp': FieldValue.serverTimestamp()});

  Stream<DocumentSnapshot> obterUsuario(String userUID) =>
      _firestore.collection("usuarios").doc(userUID).snapshots();
}
