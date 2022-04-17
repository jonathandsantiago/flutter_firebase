import 'package:cloud_firestore/cloud_firestore.dart';

class LancamentoModel {
  String id;
  double valor;
  LancamentoOrigem origem;
  Timestamp? timestamp;

  LancamentoModel(
      {required this.id,
      required this.valor,
      required this.origem,
      required this.timestamp});

  factory LancamentoModel.fromDocument(DocumentSnapshot? document) {
    if (document == null) {
      return null as LancamentoModel;
    }

    return LancamentoModel(
        id: document.id,
        valor: document['valor'].toDouble(),
        origem: LancamentoOrigem.values[document['origem']],
        timestamp: document['timestamp']);
  }

  static String obterDescricaoOrigem(LancamentoOrigem origem) {
    switch (origem) {
      case LancamentoOrigem.despesa:
        return 'Despesa';
      case LancamentoOrigem.receita:
        return 'Receita';
      case LancamentoOrigem.saqueInvestimento:
        return 'Saque em Investimentos';
      case LancamentoOrigem.depositoInvestimento:
        return 'Depósito em Investimentos';
      default:
        throw Exception('Origem $origem inválida.');
    }
  }
}

enum LancamentoOrigem {
  despesa,
  receita,
  depositoInvestimento,
  saqueInvestimento,
}
