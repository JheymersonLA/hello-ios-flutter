import 'package:flutter/cupertino.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;
  const WelcomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.star_circle_fill, size: 100, color: CupertinoColors.activeBlue),
            const SizedBox(height: 32),
            const Text(
              'Horóscopo Diário',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: CupertinoColors.label),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descubra o que os astros reservam para você hoje!',
              style: TextStyle(fontSize: 18, color: CupertinoColors.secondaryLabel),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            CupertinoButton.filled(
              child: const Text('Começar'),
              onPressed: onStart,
            ),
          ],
        ),
      ),
    );
  }
}