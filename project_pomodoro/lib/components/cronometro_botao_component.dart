import 'package:flutter/material.dart';

class CronometroBotaoComponent extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? click;

  const CronometroBotaoComponent({
    super.key,
    required this.texto,
    required this.icone,
    this.click,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20,),
        textStyle: TextStyle(fontSize: 25),
      ),
        onPressed: click,
        child: Row(
          children: [Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(icone, size: 35,),
          ), Text(texto,)],
        ));
  }
}
