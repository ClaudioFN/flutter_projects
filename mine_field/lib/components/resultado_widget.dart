import 'package:flutter/material.dart';

class ResultedWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final Function()? onReiniciar;

  const ResultedWidget({super.key, required this.venceu, required this.onReiniciar});

  Color _getCor() {
    if (venceu == null) {
      return Colors.yellow;
    } else if (venceu == true) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu == true) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: _getCor(),
          child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: onReiniciar,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              )),
        ),
      )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
