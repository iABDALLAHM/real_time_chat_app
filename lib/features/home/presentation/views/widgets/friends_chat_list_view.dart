import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friend_item.dart';

class FriendsChatListView extends StatelessWidget {
  const FriendsChatListView({super.key, required this.usersList});
  final List<UserEntity> usersList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersList.length,
      itemBuilder: (context, index) => FriendItem(
        friend: usersList[index],
        onTap: () {},
        onRemove: () {},
        onBlock: () {},
        lastSeenText: '',
      ),
    );
  }
}
