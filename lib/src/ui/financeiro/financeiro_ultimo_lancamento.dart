import 'package:intl/intl.dart';
import 'package:flutter_firebase/src/models/lancamento_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';

class FinanceiroUltimoLancamento extends StatelessWidget {
  final LancamentoModel? ultimoLancamento;
  final NumberFormat _formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  FinanceiroUltimoLancamento(this.ultimoLancamento, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ultimoLancamento != null) {
      return Center(
        child: Column(
          children: <Widget>[
            const Text(
              "Último lançamento",
              style: TextStyle(
                  color: ColorConstant.colorMain,
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0),
            ),
            Text(
              "${LancamentoModel.obterDescricaoOrigem(ultimoLancamento!.origem)} no valor de",
              style: const TextStyle(
                  color: ColorConstant.colorMain,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0),
            ),
            Text(
              _formatter.format(ultimoLancamento!.valor),
              style: const TextStyle(
                  color: ColorConstant.colorMain,
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text(
          "Nenhum lançamento recente",
          style: TextStyle(
              color: ColorConstant.colorMain,
              fontWeight: FontWeight.w600,
              fontSize: 15.0),
        ),
      );
    }
  }
}
