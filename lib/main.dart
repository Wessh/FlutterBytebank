// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferências'),
      ),
      body: Text('Body!'),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
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
        // ignore: prefer_const_literals_to_create_immutables
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

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

class Transferencia {
  late final double valor;
  late final int numeroConta;
  Transferencia(this.valor, this.numeroConta);
}
