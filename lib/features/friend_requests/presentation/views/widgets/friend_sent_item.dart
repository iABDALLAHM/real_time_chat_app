import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/friend_request_with_user.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/accepted_friend_ship_state.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/pending_friend_ship_state.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/rejected_friend_ship_state.dart';

class FriendSentItem extends StatelessWidget {
  const FriendSentItem({super.key, required this.friendRequestWithUser});
  final FriendRequestWithUser friendRequestWithUser;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryColor,
                  child: friendRequestWithUser.userEntity.photoUrl == null
                      ? SizedBox()
                      : Text(
                          friendRequestWithUser.userEntity.displayName[0]
                              .toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              friendRequestWithUser.userEntity.displayName,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            handleDateTime(),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppTheme.textsecondaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        friendRequestWithUser.userEntity.email,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textsecondaryColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (friendRequestWithUser.friendRequestEntity.status ==
                FriendRequestStatus.pending)
              PendingSentFriendShipState(),
            if (friendRequestWithUser.friendRequestEntity.status ==
                FriendRequestStatus.accepted)
              AcceptedFriendShipState(),
            if (friendRequestWithUser.friendRequestEntity.status ==
                FriendRequestStatus.rejected)
              RejectedFriendShipState(),
          ],
        ),
      ),
    );
  }

  String handleDateTime() {
    return friendRequestWithUser.friendRequestEntity.responsedAt == null
        ? friendRequestWithUser.friendRequestEntity.createdAt.toString().split(
            " ",
          )[1]
        : friendRequestWithUser.friendRequestEntity.responsedAt.toString();
  }
}
