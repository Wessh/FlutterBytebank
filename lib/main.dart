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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controllerNumeroConta,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.account_balance,
                  color: Colors.blue,
                ),
                labelText: 'Número da conta',
                hintText: '0000',
                counter:
                    Offstage(), //Oculta o contador de caracteres usado pelo maxLength
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _controllerValor,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.monetization_on,
                  color: Colors.blue,
                ),
                labelText: 'Valor',
                hintText: '0.00',
                prefix: Text('R\$ '),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () {

                final int? numeroConta =
                    int.tryParse(_controllerNumeroConta.text);
                final double? valor = double.tryParse(_controllerValor.text);
                if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$transferenciaCriada'),
                    ),
                  );
                }
              },
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

  @override
  String toString() =>
      'Transferencia(valor: $valor, numeroConta: $numeroConta)';
}
