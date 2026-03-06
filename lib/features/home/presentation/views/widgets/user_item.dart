import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/core/functions/build_default_avatar.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/function/user_item_button_status.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/cancel_friend_request_cubit/cancel_friend_request_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/send_friend_request_cubit/friend_request_cubit.dart';
import 'package:uuid/uuid.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  late String currentRequestID;
  UserRelationshipStatus relationshipStatus = UserRelationshipStatus.none;

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
              child: buildDefaultAvatar(name: widget.userEntity.displayName),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userEntity.displayName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.userEntity.email,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textsecondaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            userItemButtonStatus(
              onTap: () {
                final requestId = Uuid().v4();
                if (relationshipStatus == UserRelationshipStatus.none) {
                  context.read<SendFriendRequestCubit>().sendRequest(
                    friendRequestEntity: FriendRequestEntity(
                      status: FriendRequestStatus.pending,
                      id: requestId,
                      senderId: getUserData().uId,
                      receiverId: widget.userEntity.uId,
                      createdAt: DateTime.now(),
                    ),
                  );

                  setState(() {
                    currentRequestID = requestId;
                    relationshipStatus =
                        UserRelationshipStatus.friendRequestSent;
                  });
                } else if (relationshipStatus ==
                    UserRelationshipStatus.friendRequestSent) {
                  context.read<CancelFriendRequestCubit>().cancelFriend(
                    requestId: currentRequestID,
                  );

                  setState(() {
                    relationshipStatus = UserRelationshipStatus.none;
                  });
                }
              },
              relationshipStatus: relationshipStatus,
            ),
          ],
        ),
      ),
    );
  }
}
