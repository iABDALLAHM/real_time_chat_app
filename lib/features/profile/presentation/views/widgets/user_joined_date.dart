import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_month.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class UserJoinedDate extends StatelessWidget {
  const UserJoinedDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Joined ${getMonth(month: getUserData().createdAt.month)} ${getUserData().createdAt.year}",
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppTheme.textsecondaryColor),
    );
  }
}
