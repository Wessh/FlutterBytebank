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

/* StatelessWidget = Conteudo de forma estatica
   * StatefulWidget = Tem a capacidade de modificar itens de forma dinamica
   */
class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencia = [];//Cria uma lista vazia

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder( //.builder permite q a lista seja dinamica
        itemCount: widget._transferencia.length, // verifica quantos itens tem na lista
        itemBuilder: (context, index) { //Recebe o contexto e o indice = posição do item dentro do contexto
          final transferencia = widget._transferencia[index]; //
          return ItemTransferencia(transferencia); // Retorna o widget ItemTransferencia com transferencia referente a aquele indice
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<dynamic> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })); //Usado para ir para outra página
          future.then((transferenciaRecebida) {
            setState(() { // Pra enviar a modificação do state
              widget._transferencia.add(transferenciaRecebida);
            });
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