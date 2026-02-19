// import 'package:flutter/material.dart';
// import 'package:real_time_chat_app/core/entities/chat_entity.dart';
// import 'package:real_time_chat_app/core/entities/user_entity.dart';
// import 'package:real_time_chat_app/features/home/presentation/views/widgets/friend_item.dart';

// class FriendsChatListView extends StatelessWidget {
//   const FriendsChatListView({
//     super.key,
//     required this.usersList,
//     required this.chat,
//   });
//   final List<UserEntity> usersList;
//   final List<ChatEntity> chat;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: usersList.length,
//       itemBuilder: (context, index) => FriendItem(
//         otherUser: usersList[index],
//         lastMessageTime: '',
//         onTap: () {},
//         onRemove: () {},
//         onBlock: () {},
//         chat: chat[index],
//       ),
//     );
//   }
// }
