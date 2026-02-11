import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    required this.onRemove,
    required this.onBlock,
    required this.onTap,
  });

  final VoidCallback onRemove;
  final VoidCallback onBlock;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "message",
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Message"),
            leading: Icon(
              Icons.chat_bubble_outline,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        PopupMenuItem(
          value: "Remove",
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Remove Friend"),
            leading: Icon(
              Icons.person_remove_outlined,
              color: AppTheme.errorColor,
            ),
          ),
        ),
        PopupMenuItem(
          value: "block",
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text("Block User"),
            leading: Icon(Icons.block, color: AppTheme.errorColor),
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case "Remove":
            onRemove();
            break;
          case "block":
            onBlock();
            break;
          case "message":
            onTap();
            break;
          default:
            onTap();
        }
      },
    );
  }
}
