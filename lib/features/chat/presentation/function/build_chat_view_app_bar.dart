import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

import '../../../../core/functions/build_default_avatar.dart';

AppBar buildChatViewAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppTheme.primaryColor,
          child: ClipOval(child: buildDefaultAvatar(name: "A")),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Abdallah",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Online",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.successColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),

    actions: [
      PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "delete",
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Delete Chat"),
              leading: Icon(Icons.delete_outline, color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    ],
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    ),
  );
}
