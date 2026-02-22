import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/friend_ship_with_user_entity.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friend_item.dart';

class FriendsChatListView extends StatelessWidget {
  const FriendsChatListView({
    super.key,
    required this.friendShipWithUserEntityList,
  });
  final List<FriendShipWithUserEntity> friendShipWithUserEntityList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendShipWithUserEntityList.length,
      itemBuilder: (context, index) => FriendItem(
        friend: friendShipWithUserEntityList[index].userEntity,
        onTap: () {
          Navigator.pushNamed(context, ChatView.routeName, arguments: {});
        },
        onRemove: () {

        },
        onBlock: () {
          
        },
        lastSeenText:
            "${friendShipWithUserEntityList[index].friendshipEntity.createdAt.day.toString()}-${friendShipWithUserEntityList[index].friendshipEntity.createdAt.month.toString()}-${friendShipWithUserEntityList[index].friendshipEntity.createdAt.year.toString()}",
      ),
    );
  }
}
