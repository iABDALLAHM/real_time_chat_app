import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/chat_view_body.dart';

import '../function/build_chat_view_app_bar.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userEntity});
  static const String routeName = "chat";
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildChatViewAppBar(context, user: userEntity),
      body: ChatViewBody(),
    );
  }
}
