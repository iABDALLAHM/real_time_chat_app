import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/message_input.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/my_message.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  List<String> messages = [];
  String currentMessage = "";
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // this is the initial state of the conversation of two people that is the empty chat widget !!
        // EmptyChatWidget(),
        // Expanded messages List
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: MyMessage(message: messages[index]),
              );
            },
          ),
        ),
        MessageInput(
          onPressed: () {
            currentMessage = textController.text.trim();
            if (currentMessage.isEmpty) return;
            setState(() {
              messages.insert(0, currentMessage);
            });
            textController.clear();
          },
          textController: textController,
        ),
      ],
    );
  }
}
