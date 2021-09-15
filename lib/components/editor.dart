import 'package:flutter/material.dart';

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
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon, color: color) : null,
          // Verifica se o valor do icone é nulo, caso seja, não mostra icone.
          labelText: label,
          hintText: tip,
          prefix: prefixInput,
          counter:
          const Offstage(), //Oculta o contador de caracteres usado pelo maxLength
        ),
        keyboardType: TextInputType.number,
        maxLength: maxLength,
      ),
    );
  }
}