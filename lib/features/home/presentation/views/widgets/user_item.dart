import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/send_friend_request_bloc_builder.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userEntity, required this.onTap});
  final UserEntity userEntity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.primaryColor,
              child: Text(
                userEntity.displayName.isNotEmpty
                    ? userEntity.displayName.toUpperCase()[0]
                    : "?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userEntity.displayName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEntity.email,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textsecondaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SendFriendRequestBlocBuilder(
              userEntity: userEntity,
              friendRequestEntity: FriendRequestEntity(
                id: getUserData().uId,
                senderId: getUserData().uId,
                receiverId: userEntity.uId,
                createdAt: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
