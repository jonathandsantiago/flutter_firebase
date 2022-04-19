import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/src/models/lancamento_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/src/services/financeiro_service.dart';
import 'package:flutter_firebase/src/services/usuario_service.dart';
import 'package:flutter_firebase/src/ui/financeiro/financeiro_ultimo_lancamento.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';

class FinanceiroDetalhes extends StatelessWidget {
  final FinanceiroService _financeiroService = FinanceiroService();
  final UsuarioService _usuarioService = UsuarioService();
  final double _totalDespesa = 0;
  final NumberFormat _formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  FinanceiroDetalhes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(8), bottom: Radius.circular(8)),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: _financeiroService
            .obterLancamentos(_usuarioService.usuarioLogadoId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];

            double totalDespesa = 0;
            double totalReceita = 0;
            double totalDepositoInvestimento = 0;
            double totalSaqueInvestimento = 0;

            for (var lancamento in docs) {
              switch (LancamentoOrigem.values[lancamento['origem']]) {
                case LancamentoOrigem.despesa:
                  totalDespesa += lancamento['valor'].toDouble();
                  break;
                case LancamentoOrigem.receita:
                  totalReceita += lancamento['valor'].toDouble();
                  break;
                case LancamentoOrigem.depositoInvestimento:
                  totalDepositoInvestimento += lancamento['valor'].toDouble();
                  break;
                case LancamentoOrigem.saqueInvestimento:
                  totalSaqueInvestimento += lancamento['valor'].toDouble();
                  break;
              }
            }

            double saldo = totalReceita - totalDespesa;
            double saldoInvestimento =
                totalDepositoInvestimento - totalSaqueInvestimento;

            return Stack(
              children: <Widget>[
                const Positioned(
                  top: 16,
                  left: 16,
                  child: Icon(
                    Icons.credit_card,
                    color: Colors.black38,
                    size: 32.0,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .14,
                  left: 16,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "SALDO ATUAL",
                          style: TextStyle(
                              color: ColorConstant.colorMain,
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0),
                        ),
                        Text(
                          _formatter.format(saldo),
                          style: TextStyle(
                              color: saldo < 0 ? Colors.red : Colors.green,
                              fontWeight: FontWeight.w400,
                              fontSize: 30.0),
                        ),
                        Row(
                          children: <Widget>[
                            const Text(
                              "Total receita ",
                              style: TextStyle(
                                  color: ColorConstant.colorMain,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                            Text(
                              _formatter.format(totalReceita),
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text(
                              "Total despesa ",
                              style: TextStyle(
                                  color: ColorConstant.colorMain,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                            Text(
                              _formatter.format(totalDespesa),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Text(
                              "Total investimento ",
                              style: TextStyle(
                                  color: ColorConstant.colorMain,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                            Text(
                              _formatter.format(saldoInvestimento),
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 20,
                  child: Hero(
                    tag: 'progress-budget',
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SizedBox(
                        height: 10,
                        width: MediaQuery.of(context).size.height * .25,
                        child: LinearProgressIndicator(
                          backgroundColor:
                              saldo < 0 ? Colors.red : Colors.green,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.orange),
                          value: _totalDespesa,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: 75.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black12,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _financeiroService.obterUltimoLancamento(
                          _usuarioService.usuarioLogadoId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot> docs =
                              snapshot.data?.docs ?? [];
                          LancamentoModel? lancamento = docs.isNotEmpty
                              ? LancamentoModel.fromDocument(docs[0])
                              : null;
                          return FinanceiroUltimoLancamento(lancamento);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
