import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        const Text('Updates'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/profile');
          },
          child: const Text('Go to Profile'),
        ),
      ],
    );
  }
}