import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.isSecondButton = false,
  });
  final Widget child;
  final Function() onPressed;
  final bool isSecondButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isSecondButton ? AppTheme.primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppTheme.primaryColor),
        ),
        backgroundColor: isSecondButton ? Colors.white : AppTheme.primaryColor,
      ),
      child: child,
    );
  }
}
