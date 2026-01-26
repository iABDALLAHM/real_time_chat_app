import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class ProfileBadge extends StatelessWidget {
  const ProfileBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "ChatApp v1.0.0",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: AppTheme.textsecondaryColor,
      ),
    );
  }
}