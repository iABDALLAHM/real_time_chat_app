import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class ApplicationPrimaryIcon extends StatelessWidget {
  const ApplicationPrimaryIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: 80,
      height: 80,
      child: Icon(
        Icons.chat_bubble_rounded,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}