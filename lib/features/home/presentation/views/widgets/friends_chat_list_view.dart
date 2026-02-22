import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_ship_with_user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/friend_ship_cubit/friend_ship_cubit.dart';
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
          context.read<FriendShipCubit>().removeFriendShip(
            user1Id: friendShipWithUserEntityList[index].friendshipEntity.id,
            user2Id: getUserData().uId,
          );
        },
        onBlock: () {
          context.read<FriendShipCubit>().blockFriendShip(
            blockedId: friendShipWithUserEntityList[index].friendshipEntity.id,
            blockerId: getUserData().uId,
          );
        },
        lastSeenText:
            "${friendShipWithUserEntityList[index].friendshipEntity.createdAt.day.toString()}-${friendShipWithUserEntityList[index].friendshipEntity.createdAt.month.toString()}-${friendShipWithUserEntityList[index].friendshipEntity.createdAt.year.toString()}",
      ),
    );
  }
}
