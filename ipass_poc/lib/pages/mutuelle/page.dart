import 'package:flutter/material.dart';

class MutuellePage extends StatelessWidget {
  const MutuellePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutuelle de sante'),
      ),
      body: const Center(
        child: Text('Mutuelle'),
      ),
    );
  }
}