import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/build_default_avatar.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friend_request_bloc_consumer.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userEntity});
  final UserEntity userEntity;

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
              child: buildDefaultAvatar(name: userEntity.displayName),
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
            SendFriendRequestBlocConsumer(
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
