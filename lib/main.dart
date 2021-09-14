// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  const ListaTransferencia({Key? key}) : super(key: key);

  /*
   * StatelessWidget = Conteudo de forma estatica
   * StatefulWidget = Tem a capacidade de modificar itens de forma dinamica
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(
            Transferencia(100.2, 514),
          ),
          ItemTransferencia(
            Transferencia(1300.2, 5144),
          ),
          ItemTransferencia(
            Transferencia(4020.63, 6748),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));  //Usado para ir para outra página
          future.then((transferenciaRecebida){
            debugPrint('Chegou no future.');
            debugPrint('$transferenciaRecebida');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Column(
        children: [
          Editor(
            controller: _controllerNumeroConta,
            label: 'Número da conta',
            tip: '0000',
            maxLength: 4,
            icon: Icons.account_balance,
            color: Colors.blue,
          ),
          Editor(
            controller: _controllerValor,
            label: 'Valor',
            tip: '0.00',
            prefixInput: Text('R\$ '),
            icon: Icons.monetization_on,
            color: Colors.blue,
          ),
          ElevatedButton(
            onPressed: () => _criaTransferencia(context),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double? valor = double.tryParse(_controllerValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$transferenciaCriada'),
        ),
      );
    }
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  // ignore: prefer_const_constructors_in_immutables
  ItemTransferencia(this._transferencia, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(_transferencia.valor.toString()),
          subtitle: Text(_transferencia.numeroConta.toString()),
        ));
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? icon;
  final Color? color;
  final String? label;
  final String? tip;
  final Text? prefixInput;
  final int? maxLength;

  const Editor(
      {Key? key,
      this.controller,
      this.icon,
      this.color,
      this.label,
      this.tip,
      this.maxLength,
      this.prefixInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon, color: color) : null,
          // Verifica se o valor do icone é nulo, caso seja, não mostra icone.
          labelText: label,
          hintText: tip,
          prefix: prefixInput,
          counter:
              Offstage(), //Oculta o contador de caracteres usado pelo maxLength
        ),
        keyboardType: TextInputType.number,
        maxLength: maxLength,
      ),
    );
  }
}

class Transferencia {
  late final double valor;
  late final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() =>
      'Transferencia(valor: $valor, numeroConta: $numeroConta)';
}
