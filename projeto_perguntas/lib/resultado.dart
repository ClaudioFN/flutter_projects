import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() quandoReiniciarQuestionario;

  Resultado(this.pontuacao, this.quandoReiniciarQuestionario);

  String get fraseResultado {
    if (pontuacao < 14) {
      return 'Parabéns.';
    } else if (pontuacao < 17) {
      return 'Tenta Mais Um Pouco!';
    } else if (pontuacao < 20) {
      return 'Tá Quase Lá!';
    } else {
      return 'Ae meu consagrado!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(fraseResultado, style: TextStyle(fontSize: 28))),
        TextButton(
          onPressed: quandoReiniciarQuestionario,
          child: Text('Jogar Novamente?'),
          style: TextButton.styleFrom(
            maximumSize: Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.blue,
            primary: Colors.white,
          ),
        )
      ],
    );
  }
}
