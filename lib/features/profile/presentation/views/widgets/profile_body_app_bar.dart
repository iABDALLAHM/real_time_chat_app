import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class ProfileBodyAppBar extends StatelessWidget {
  const ProfileBodyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        Spacer(),
        Text(
          "Profile",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text("Edit", style: TextStyle(color: AppTheme.primaryColor)),
        ),
      ],
    );
  }
}
