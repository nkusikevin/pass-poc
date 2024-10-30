import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipass_poc/components/payment_card.dart';

class MakePayments extends StatelessWidget {
  const MakePayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Payment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PaymentCard(
                title: 'Traffic Fine',
                icon: FontAwesomeIcons.ticket,
                color: Color(0xFF2684FF),
                onTap: () {
                  // Handle traffic fine payment
                },
              ),
              const SizedBox(height: 16.0),
              PaymentCard(
                title: 'Mutuelle de sante',
                color: Color(0xFF9C8BFF),
                icon: FontAwesomeIcons.starOfLife,
                onTap: () {
                  // Handle community health insurance payment
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
