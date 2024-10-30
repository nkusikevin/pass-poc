import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipass_poc/components/home_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ipass_poc/pages/make_payments.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          const Text(
            'Hello, Isimbi!',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          const Text(
            'What would you like to do today?',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            height: 98,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFF6CE9A6)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(CupertinoIcons.bell, color: Colors.green, size: 30),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Your definitive driving test is on Tuesday, May 04, below is your test code ',
                          style: TextStyle(fontSize: 16),
                          softWrap: true,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'NYG12345678900987653467',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          PaymentCard(
            title: 'Make a payment',
            subtitle: 'Traffic fines, community health based insurance ...',
            icon: FontAwesomeIcons.handHoldingDollar,
            backgroundGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF219CFF), Color(0xFF1975BF)],
            ),
            shapesColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MakePayments()),
              );
            },
          ),
          const SizedBox(height: 16),
          PaymentCard(
            title: 'My certificates',
            subtitle: 'Birth certificate, celibacy certificate and more ...',
            icon: FontAwesomeIcons.file,
            backgroundGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8413F5), Color(0xFF611FA2)],
            ),
            shapesColor: Colors.white,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
