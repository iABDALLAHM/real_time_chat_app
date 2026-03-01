import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/user_with_chat_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/restore_unreadCount_messages_cubit/restore_unread_count_messages_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/chat_item.dart';

class ChatItemListView extends StatelessWidget {
  const ChatItemListView({super.key, required this.userWithChatList});
  final List<UserWithChatEntity> userWithChatList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userWithChatList.length,
      itemBuilder: (context, index) {
        return ChatItem(
          otherUser: userWithChatList[index].userEntity,
          lastMessageTime:
              "${userWithChatList[index].chatEntity.lastMessageTime?.day.toString()}-${userWithChatList[index].chatEntity.lastMessageTime?.month.toString()}-${userWithChatList[index].chatEntity.lastMessageTime?.year.toString()}",
          onTap: () {
            updateUnReadMessagesCount(index: index, context: context);
            Navigator.of(context).pushNamed(
              ChatView.routeName,
              arguments: userWithChatList[index].userEntity,
            );
          },
          chat: userWithChatList[index].chatEntity,
        );
      },
    );
  }

  void updateUnReadMessagesCount({
    required int index,
    required BuildContext context,
  }) {
    var chatId = userWithChatList[index].chatEntity.id;

    int myunreadCount =
        userWithChatList[index].chatEntity.unreadCount[getUserData().uId] ?? 0;
    if (myunreadCount.round() > 0) {
      context.read<RestoreUnReadCountMessagesCubit>().restoreunReadCount(
        userId: getUserData().uId,
        chatId: chatId,
      );
    }
  }
}
