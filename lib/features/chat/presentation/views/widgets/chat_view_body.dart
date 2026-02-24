import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/get_messages_stream_cubit/get_messages_stream_cubit.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/get_messages_stream_cubit/get_messages_stream_state.dart';
import 'package:real_time_chat_app/features/chat/presentation/manager/send_message_cubit/send_message_cubit.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/empty_chat_widget.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/message_input.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/widgets/my_message.dart';
import 'package:uuid/uuid.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key, required this.userEntity});
  final UserEntity userEntity;
  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  @override
  void initState() {
    context.read<GetMessagesStreamCubit>().getMessages(
      user1Id: "n4iCQ1qvmAbMBdoBEJJ5xpQRagG3",
      user2Id: "receiverId",
    );
    super.initState();
  }

  List<String> messages = [];
  String currentMessage = "";
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Expanded messages List
        Expanded(
          child: BlocBuilder<GetMessagesStreamCubit, GetMessagesStreamStates>(
            builder: (context, state) {
              if (state is SuccessGetMessagesStreamState) {
                return ListView.builder(
                  reverse: true,
                  itemCount: state.messagesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: MyMessage(
                        message: state.messagesList[index].content,
                      ),
                    );
                  },
                );
              } else {
                return EmptyChatWidget();
              }
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
            MessageEntity messageEntity = MessageEntity(
              id: Uuid().v4(),
              senderId: getUserData().uId,
              receiverId: "receiverId",
              content: currentMessage,
              timeStamp: DateTime.now(),
            );
            context.read<SendMessageCubit>().sendMessage(
              message: messageEntity,
            );
          },
          textController: textController,
        ),
      ],
    );
  }
}
