import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),
        const Text('Profile'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: const Text('Go to Home'),
        ),
      ],
    );
  }
}
