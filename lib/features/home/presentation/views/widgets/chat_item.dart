import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import '../../../../../core/functions/build_default_avatar.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.otherUser,
    required this.lastMessageTime,
    required this.onTap,
    required this.chat,
  });

  final UserEntity otherUser;
  final ChatEntity chat;
  final String lastMessageTime;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unreadCount = chat.getUnreadCount(userId: getUserData().uId);
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
                    child: otherUser.photoUrl != null
                        ? ClipOval(
                            child: Image.network(
                              otherUser.photoUrl!,
                              width: 56,
                              fit: BoxFit.cover,
                              height: 56,
                              errorBuilder: (context, error, stackTrace) {
                                return buildDefaultAvatar(
                                  name: otherUser.displayName,
                                );
                              },
                            ),
                          )
                        : buildDefaultAvatar(name: otherUser.displayName),
                  ),

                  if (otherUser.isOnline)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            otherUser.displayName,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight:
                                      unreadCount >
                                          0 //
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        if (lastMessageTime.isNotEmpty)
                          Text(
                            lastMessageTime,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontWeight:
                                      unreadCount >
                                          0 //
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color:
                                      unreadCount >
                                          0 //
                                      ? AppTheme.primaryColor
                                      : AppTheme.textsecondaryColor,
                                ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              if (chat.lastMessageSenderId ==
                                  getUserData().uId) ...[
                                Icon(
                                  getSeenStatusIcon(),
                                  size: 14,
                                  color: getSeenStatusColor(),
                                ),
                                const SizedBox(width: 4),
                              ],

                              Expanded(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  chat.lastMessage ?? "No Message Yet",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color:
                                            unreadCount >
                                                0 //
                                            ? AppTheme.primaryColor
                                            : AppTheme.textsecondaryColor,
                                        fontWeight:
                                            unreadCount >
                                                0 //
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (unreadCount > 0) ...[
                          const SizedBox(width: 4 * 2),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            margin: EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              unreadCount > 99
                                  ? "+99"
                                  : unreadCount.toString(), //
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (chat.lastMessageSenderId == getUserData().uId) ...[
                      const SizedBox(height: 2),
                      Text(
                        getSeenStatusText(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: getSeenStatusColor(),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData getSeenStatusIcon() {
    return Icons.done_all;
  }

  String getSeenStatusText() {
    return "";
  }

  Color getSeenStatusColor() {
    var lastSeenDate = chat.lastSeenBy[getUserData().uId];
    if (lastSeenDate == DateTime.now()) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  void showChatOptions() {}
}


// video 16