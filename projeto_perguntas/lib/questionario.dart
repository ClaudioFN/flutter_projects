import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) responder;

  Questionario(
      {required this.perguntas,
      required this.perguntaSelecionada,
      required this.responder});

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas.elementAt(perguntaSelecionada).cast()['respostas']
            as List<Map<String, Object>>
        : [];
    return Column(
      children: <Widget>[
        Questao(perguntas.elementAt(perguntaSelecionada)['texto'].toString()),
        ...respostas
            .map((resp) => Resposta(resp['texto'] as String,
                () => responder(int.parse(resp['pontuacao'].toString())))
                )
            .toList(), // Spread que pega cada elemento para incluir em modo lista | map = transformar
      ],
    );
  }
}
