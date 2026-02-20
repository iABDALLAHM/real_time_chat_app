import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/chat/presentation/views/chat_view.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_chat_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/chat_item.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_floating_action_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_sections_tabs.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/no_conversation_widget.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key, required this.onChange});
  static const String routeName = "Chat";
  final Function(int) onChange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onChange: (value) {
          onChange(value);
        },
      ),
      appBar: buildChatBodyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: "Enter To search conversations",
                hintText: "Search conversations...",
                onSaved: (value) {},
                prefixIcon: Icon(Icons.search),
              ),
              const SizedBox(height: 8),
              CustomSectionsTabs(onChange: (value) {}),
              ChatItem(
                otherUser: UserEntity(
                  uId: "uId",
                  email: "email",
                  displayName: "displayName",
                  lastSeen: DateTime.now(),
                  createdAt: DateTime.now(),
                ),
                lastMessageTime: '',
                onTap: () {
                  Navigator.pushNamed(context, ChatView.routeName,arguments: {});
                },
                chat: ChatEntity(
                  id: "id",
                  participants: [],
                  unreadCount: {},
                  lastMessageTime: DateTime.now(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              ),
              // NoConversationsWidget(
              //   onChange: (value) {
              //     onChange(value);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
