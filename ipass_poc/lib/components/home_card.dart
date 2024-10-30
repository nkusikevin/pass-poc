import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Gradient backgroundGradient;
  final Color iconColor;
  final Color? shapesColor;

  const PaymentCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.payments_outlined,
    this.onTap,
    this.backgroundGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF219CFF), Color(0xFF1975BF)],
    ),
    this.iconColor = Colors.white,
    this.shapesColor, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 216,
      child: Card(
        elevation: 0,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            // Gradient background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: backgroundGradient,
                  ),
                ),
              ),
            ),
      
            // Decorative shapes
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (shapesColor ?? Colors.white).withOpacity(0.1),
                  border: Border.all(
                    color: (shapesColor ?? Colors.white).withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -20,
              right: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (shapesColor ?? Colors.white).withOpacity(0.1),
                  border: Border.all(
                    color: (shapesColor ?? Colors.white).withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
      
            // Main content
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
