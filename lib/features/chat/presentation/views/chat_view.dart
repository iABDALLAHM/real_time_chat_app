import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/chat_view_body.dart';

import '../function/build_chat_view_app_bar.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static const String routeName = "chat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildChatViewAppBar(context), body: ChatViewBody());
  }
}
