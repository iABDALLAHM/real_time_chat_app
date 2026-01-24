import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class ResetPasswordHomeIcon extends StatelessWidget {
  const ResetPasswordHomeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppTheme.primaryColor.withOpacity(0.1),
        ),
        child: Icon(
          Icons.lock_reset_rounded,
          size: 50,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}


