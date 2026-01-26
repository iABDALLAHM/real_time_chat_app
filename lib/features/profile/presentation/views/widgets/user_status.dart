import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      getUserData().isOnline ? "Online" : "Offline",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: getUserData().isOnline
            ? AppTheme.successColor
            : AppTheme.textsecondaryColor,
      ),
    );
  }
}
