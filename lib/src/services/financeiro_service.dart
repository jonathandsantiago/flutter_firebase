import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/models/lancamento_model.dart';
import 'package:flutter_firebase/src/repositories/financeiro_repository.dart';
import 'package:flutter_firebase/src/services/service_base.dart';
import 'package:flutter_firebase/src/services/usuario_service.dart';

class FinanceiroService implements ServiceBase {
  final UsuarioService _usuarioService = UsuarioService();
  final FinanceiroRepository _financeiroRepository = FinanceiroRepository();

  Stream<QuerySnapshot> obterLancamentos(String? userUID) => userUID == null
      ? null as Stream<QuerySnapshot>
      : _financeiroRepository.obterLancamentos(userUID);

  Stream<QuerySnapshot> obterUltimoLancamento(String? userUID) =>
      userUID == null
          ? null as Stream<QuerySnapshot>
          : _financeiroRepository.obterUltimoLancamento(userUID);

  Future<void> adicionarDespesa(double valor) async {
    if (_usuarioService.usuarioLogadoId == null) {
      return;
    }

    return _financeiroRepository.lancarConta(
        _usuarioService.usuarioLogadoId ?? '', LancamentoOrigem.despesa, valor);
  }

  Future<void> adicionarReceita(double value) async {
    if (_usuarioService.usuarioLogadoId == null) {
      return;
    }

    return _financeiroRepository.lancarConta(
        _usuarioService.usuarioLogadoId ?? '', LancamentoOrigem.receita, value);
  }

  Future<void> depositarInvestimento(double valor) async {
    if (_usuarioService.usuarioLogadoId == null) {
      return;
    }

    return _financeiroRepository.lancarConta(
        _usuarioService.usuarioLogadoId ?? '',
        LancamentoOrigem.depositoInvestimento,
        valor);
  }

  Future<void> sacarInvestimento(double valor) async {
    if (_usuarioService.usuarioLogadoId == null) {
      return;
    }

    return _financeiroRepository.lancarConta(
        _usuarioService.usuarioLogadoId ?? '',
        LancamentoOrigem.saqueInvestimento,
        valor);
  }

  @override
  void dispose() async {}
}
