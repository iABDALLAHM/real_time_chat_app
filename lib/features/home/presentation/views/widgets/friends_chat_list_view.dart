import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/friend_item.dart';

class FriendsChatListView extends StatelessWidget {
  const FriendsChatListView({super.key, required this.friendsList});
  final List<FriendItem> friendsList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friendsList.length,
      itemBuilder: (context, index) => friendsList[index],
    );
  }
}
