import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/src/services/financeiro_service.dart';
import 'package:flutter_firebase/src/utils/values/colors.dart';
import 'package:flutter_firebase/src/widgets/button_card.dart';

class HomeActions extends StatefulWidget {
  const HomeActions({Key? key}) : super(key: key);

  @override
  _HomeActionsState createState() {
    return _HomeActionsState();
  }
}

class _HomeActionsState extends State<HomeActions> {
  final FinanceiroService _financeiroService = FinanceiroService();

  final formKey = GlobalKey<FormState>();
  double? valor;

  void _abrirModalLancamento(
      BuildContext context, String title, VoidCallback confirmCallback) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .7,
            child: Wrap(children: <Widget>[
              ListTile(
                leading: const Icon(Icons.money_off,
                    size: 35.0, color: ColorConstant.colorMain),
                title: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 26.0, color: ColorConstant.colorMain),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            locale: 'pt-br',
                            decimalDigits: 2,
                            symbol: "R\$",
                          )
                        ],
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Valor é obrigatório';
                          } else if (double.tryParse(value
                                  .replaceAll("R\$", "")
                                  .replaceAll(" ", "")
                                  .replaceAll(".", "")
                                  .replaceAll(",", ".")) ==
                              null) {
                            return 'O Valor informado é invalido';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String? value) {
                          setState(() {
                            valor = double.tryParse(value!
                                    .replaceAll("R\$", "")
                                    .replaceAll(" ", "")
                                    .replaceAll(".", "")
                                    .replaceAll(",", ".")) ??
                                0;
                          });
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 200.0),
                          child: FloatingActionButton.extended(
                            label: const Text('Confirmar'),
                            backgroundColor: ColorConstant.colorMain,
                            icon: const Icon(
                              Icons.check,
                              size: 24.0,
                            ),
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                confirmCallback();
                                Navigator.pop(context);
                              }
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        ButtonCard(
          icon: Icons.money_off,
          iconSize: 32.0,
          actionText: "Incluir despesa",
          callback: () {
            _abrirModalLancamento(context, "Incluir Despesa", () async {
              await _financeiroService.adicionarDespesa(valor!);
            });
          },
        ),
        ButtonCard(
            icon: Icons.monetization_on,
            iconSize: 32.0,
            actionText: "Incluir Receita",
            callback: () {
              _abrirModalLancamento(context, "Incluir Receita", () async {
                await _financeiroService.adicionarReceita(valor!);
              });
            }),
        ButtonCard(
            icon: Icons.mood,
            iconSize: 32.0,
            actionText: "Investir",
            callback: () {
              _abrirModalLancamento(context, "Investir", () async {
                await _financeiroService.depositarInvestimento(valor!);
              });
            }),
        ButtonCard(
            icon: Icons.mood_bad,
            iconSize: 32.0,
            actionText: "Resgar Investimento",
            callback: () {
              _abrirModalLancamento(context, "Resgatar", () async {
                await _financeiroService.sacarInvestimento(valor!);
              });
            }),
        ButtonCard(
          icon: Icons.group_add,
          iconSize: 32.0,
          actionText: "Indicar amigos",
          callback: () {},
        ),
        ButtonCard(
          icon: Icons.help_outline,
          iconSize: 32.0,
          actionText: "Sobre",
          callback: () {},
        ),
      ],
    );
  }
}
