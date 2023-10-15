import 'package:flutter/material.dart';
import 'package:mine_field/components/tabuleiro_widget.dart';
import 'package:mine_field/models/explosao_exception.dart';
import 'package:mine_field/models/tabuleiro.dart';
import '../components/resultado_widget.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({super.key});

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro?.reinciar();
    });
  }

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      try {
        campo.abrir();

        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro?.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      campo.alternarMarcacao();

      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro =
          Tabuleiro(linhas: qtdeLinhas, colunas: qtdeColunas, qtdeBombas: 3);
    }

    return _tabuleiro ?? Tabuleiro(linhas: 1, colunas: 1, qtdeBombas: 0);
  }

  @override
  Widget build(BuildContext context) {
    //Campo vizinho1 = Campo(coluna: 0, linha: 1);
    //Campo vizinho2 = Campo(coluna: 1, linha: 1);

    //Campo campo = Campo(linha: 0, coluna: 0);
    //campo.adicionarVizinho(vizinho1);
    //campo.adicionarVizinho(vizinho2);
    //vizinho1.minar();
    //vizinho1.minar();

    //try {
    //  //campo.minar();
    //  //campo.abrir();
    //  campo.alternarMarcacao();
    //} on ExplosaoException {

    //}

    return MaterialApp(
      home: Scaffold(
        appBar: ResultedWidget(venceu: _venceu, onReiniciar: _reiniciar),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(constraints.maxWidth, constraints.maxHeight),
                onAbrir: _abrir,
                onAlternarMarcacao: _alternarMarcacao,
              );
            },
          ),
        ),
      ),
    );
  }
}
