import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final IconData? iconData;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? secondaryButtonColor;
  final Color? primaryButtonColor;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.iconData,
    this.iconColor,
    this.iconBackgroundColor, required Icon icon,
    this.secondaryButtonColor,
    this.primaryButtonColor,
  }) : super(key: key);

  Widget _buildIcon() {
    if (iconData == null) return const SizedBox.shrink();

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: iconBackgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Icon(
        iconData,
        size: 32,
        color: iconColor ?? Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                if (secondaryButtonText != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                          side:BorderSide(color: Colors.grey.shade400, width: 1)
                        ),
                      
                      ),
                      onPressed: onSecondaryButtonPressed ??
                          () => Navigator.pop(context),
                      child: Text(secondaryButtonText! , style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor ?? Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    onPressed:
                        onPrimaryButtonPressed ?? () => Navigator.pop(context),
                    child: Text(primaryButtonText ?? 'OK'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
