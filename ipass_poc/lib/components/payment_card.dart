import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const PaymentCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 50, // Match height with icon container
            padding: const EdgeInsets.only(
                top: 12), // Adjust this value to vertically align the text
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
