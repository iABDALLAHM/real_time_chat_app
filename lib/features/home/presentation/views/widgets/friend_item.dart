import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

import '../../../../../core/functions/build_default_avatar.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    super.key,
    required this.friend,
    required this.lastSeenText,
    required this.onTap,
    required this.onRemove,
    required this.onBlock,
  });
  final UserEntity friend;
  final String lastSeenText;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final VoidCallback onBlock;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.primaryColor,
                    child: friend.photoUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Placeholder(),
                          )
                        : buildDefaultAvatar(name: friend.displayName),
                  ),
                  if (friend.isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: AppTheme.successColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend.displayName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      friend.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textsecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lastSeenText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: friend.isOnline
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: friend.isOnline
                            ? AppTheme.successColor
                            : AppTheme.textsecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              PopupMenuButton<String>(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
