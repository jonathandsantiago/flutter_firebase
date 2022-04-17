import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/models/lancamento_model.dart';

class FinanceiroModel {
  String id;
  List<LancamentoModel> lancamentos;

  FinanceiroModel({required this.id, required this.lancamentos});

  factory FinanceiroModel.fromDocument(DocumentSnapshot? document) {
    if (document == null) {
      return null as FinanceiroModel;
    }

    return FinanceiroModel(
        id: document.id, lancamentos: document['lancamentos']);
  }
}
