import 'package:flutter/widgets.dart';
import 'package:real_time_chat_app/core/entities/user_with_chat_entity.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/chat_view.dart';
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
          lastMessageTime:
              chats[index].chatEntity.lastMessageTime?.day.toString() ?? "",
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(ChatView.routeName, arguments: chats[index].userEntity);
          },
          chat: chats[index].chatEntity,
        );
      },
    );
  }
}
