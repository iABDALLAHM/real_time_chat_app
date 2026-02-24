import 'package:flutter/widgets.dart';
import 'package:real_time_chat_app/core/entities/user_with_chat_entity.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/chat_item.dart';

class ChatItemListView extends StatelessWidget {
  const ChatItemListView({super.key, required this.chats});
  final List<UserWithChatEntity> chats;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatItem(
          otherUser: chats[index].userEntity,
          lastMessageTime: DateTime.now().toString(),
          onTap: () {},
          chat: chats[index].chatEntity,
        );
      },
    );
  }
}
