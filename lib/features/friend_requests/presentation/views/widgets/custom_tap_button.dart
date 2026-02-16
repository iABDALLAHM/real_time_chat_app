import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class CustomTapButton extends StatelessWidget {
  const CustomTapButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onPressed, required this.length,
  });
  final String text;
  final int length;
  final IconData icon;
  final bool isSelected;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppTheme.textsecondaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              "$text ($length)",
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textsecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
