import 'package:flutter/widgets.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/friend_request_item.dart';

class FriendRequestItemListView extends StatelessWidget {
  const FriendRequestItemListView({
    super.key,
    required this.userEntityList,
    required this.friendRequestEntity,
  });
  final List<UserEntity> userEntityList;
  final List<FriendRequestEntity> friendRequestEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userEntityList.length,
      itemBuilder: (context, index) {
        return FriendRequestItem(
          userEntity: userEntityList[index],
          friendRequestEntity: friendRequestEntity[index],
          timeText: DateTime.now().toString(),
          isReceived: true,
        );
      },
    );
  }
}
