import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(color: Colors.red, backgroundColor: Colors.white,),
            SizedBox(
              height: 30,
            ),
            Text(
              'Carregando...',
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headlineMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
