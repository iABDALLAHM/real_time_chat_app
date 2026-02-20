import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/friend_request_with_user_entity.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_sent_item.dart';

class FriendSentItemListView extends StatelessWidget {
  const FriendSentItemListView({
    super.key,
    required this.friendRequestWithUser,
  });
  final List<FriendRequestWithUserEntity> friendRequestWithUser;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendRequestWithUser.length,
      itemBuilder: (context, index) {
        return FriendSentItem(
          friendRequestWithUser: friendRequestWithUser[index],
        );
      },
    );
  }
}
