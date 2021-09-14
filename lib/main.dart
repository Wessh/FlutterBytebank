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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.account_balance,
                  color: Colors.blue,
                ),
                labelText: 'Número da conta',
                hintText: '0000',
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.blue,
                ),
                labelText: 'Valor',
                hintText: '0.00',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Confirmar'),
            ),
          ),
        ],
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

class Transferencia {
  late final double valor;
  late final int numeroConta;
  Transferencia(this.valor, this.numeroConta);
}
