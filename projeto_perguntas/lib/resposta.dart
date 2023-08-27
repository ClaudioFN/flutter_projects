import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {

final String texto;

final void Function() onSelection;

Resposta(this.texto, this.onSelection);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: TextStyle(color: const Color.fromARGB(255, 255, 64, 64))
                ),
                child: Text(texto, style: TextStyle(color: Colors.white, ),),
                onPressed: onSelection,
              ),
    );
  }
}