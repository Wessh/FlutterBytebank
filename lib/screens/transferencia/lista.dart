/* StatelessWidget = Conteudo de forma estatica
   * StatefulWidget = Tem a capacidade de modificar itens de forma dinamica
   */
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import 'formulario.dart';

const _title = 'Transferências';

class ListaTransferencia extends StatefulWidget {
  final List<Transferencia> _transferencia = [];

  ListaTransferencia({Key? key}) : super(key: key); //Cria uma lista vazia

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: ListView.builder(
        //.builder permite q a lista seja dinamica
        itemCount: widget._transferencia.length,
        // verifica quantos itens tem na lista
        itemBuilder: (context, index) {
          //Recebe o contexto e o indice = posição do item dentro do contexto
          final transferencia = widget._transferencia[index]; //
          return ItemTransferencia(
              transferencia); // Retorna o widget ItemTransferencia com transferencia referente a aquele indice
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            //Navigation.push Usado para ir para outra página
            return FormularioTransferencia();
          })).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _atualiza(transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        // Pra enviar a modificação do state... usar sempre que estiver enviando dados para um stateful
        widget._transferencia.add(transferenciaRecebida);
      });
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
      leading: const Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}
