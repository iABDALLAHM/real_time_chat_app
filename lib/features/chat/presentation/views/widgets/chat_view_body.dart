import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/empty_chat_widget.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/message_input.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [EmptyChatWidget(), Spacer(), MessageInput()]);
  }
}
