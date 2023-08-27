// ignore_for_file: annotate_overrides
import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

void main() {
  runApp(PerguntaApp());
}

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;
  final _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 20},
        {'texto': 'Verde', 'pontuacao': 5},
        {'texto': 'Branco', 'pontuacao': 1}
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Coelho', 'pontuacao': 6},
        {'texto': 'Cobra', 'pontuacao': 2},
        {'texto': 'Elefante', 'pontuacao': 8},
        {'texto': 'Leão', 'pontuacao': 10}
      ]
    },
    {
      'texto': 'Qual é o seu jogo favorito?',
      'respostas': [
        {'texto': 'Halo 3', 'pontuacao': 10},
        {'texto': 'Halo Reach', 'pontuacao': 10},
        {'texto': 'Assassin\'s Creed: Brotherhood', 'pontuacao': 8},
        {'texto': 'Assassin\'s Creed: Odyssey', 'pontuacao': 10}
      ]
    }
  ];

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      // Impedir novos incrementos
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  void _reiniciarQuestionario() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas!'),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder)
            : Resultado(_pontuacaoTotal, _reiniciarQuestionario),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
