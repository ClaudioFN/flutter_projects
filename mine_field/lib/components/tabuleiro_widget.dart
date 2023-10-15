import 'package:flutter/material.dart';
import 'package:mine_field/components/campo_widget.dart';
import 'package:mine_field/models/campo.dart';
import 'package:mine_field/models/tabuleiro.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  const TabuleiroWidget({
    super.key,
    required this.tabuleiro,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos.map((e) {
          return CampoWidget(campo: e, onAbrir: onAbrir, onAlternarMarcacao: onAlternarMarcacao);
        }).toList(),
      ),
    );
  }
}
