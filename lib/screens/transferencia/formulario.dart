import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Criando Transferências';
const _labelNumConta = 'Número da conta';
const _tipNumConta = '0000';
const _labelValor = 'Valor';
const _tipValor = '0.00';
const _btnConfirmar = 'Confirmar';
const _prefixInputValor = 'R\$ ';
class FormularioTransferencia extends StatelessWidget {
  // Caso apresente bug, Ex: perder os dados do Editor, quando alterar a rotação do aparelho. Transformar em Stateful
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        // Permite da o comportamento de scroll a um widget
        child: Column(
          children: [
            Editor(
              controller: _controllerNumeroConta,
              label: _labelNumConta,
              tip: _tipNumConta,
              maxLength: 4,
              icon: Icons.account_balance,
              //color: Colors.blue,
            ),
            Editor(
              controller: _controllerValor,
              label: _labelValor,
              tip: _tipValor,
              prefixInput: const Text(_prefixInputValor),
              icon: Icons.monetization_on,
              //color: Colors.blue,
            ),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: const Text(_btnConfirmar),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double? valor = double.tryParse(_controllerValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}