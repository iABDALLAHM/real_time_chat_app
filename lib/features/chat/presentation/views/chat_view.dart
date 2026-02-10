import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/chat_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static const String routeName = "chat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChatViewBody(),
    );
  }
}
