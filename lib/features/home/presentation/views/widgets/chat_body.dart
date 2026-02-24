import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_chat_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_user_chats_stream_cubit/get_user_chats_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_user_chats_stream_cubit/get_user_chats_state.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/chat_item_list_view.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_floating_action_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_sections_tabs.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_tabs_body.dart';
// import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_tabs_body.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/no_conversation_widget.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key, required this.onChange});
  static const String routeName = "Chat";
  final Function(int) onChange;

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  int currentIndex = 0;
  @override
  void initState() {
    context.read<GetNotificationsStreamCubit>().getNotifications(
      userId: getUserData().uId,
    );
    context.read<GetUserChatsCubit>().getUserChats(userId: getUserData().uId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chatsList = context.watch<GetUserChatsCubit>().chats.isEmpty;
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onChange: (value) {
          widget.onChange(value);
        },
      ),
      appBar: buildChatBodyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CustomTextFormField(
              labelText: "Enter To search conversations",
              hintText: "Search conversations...",
              onSaved: (value) {},
              prefixIcon: Icon(Icons.search),
            ),
            const SizedBox(height: 8),
            CustomSectionsTabs(
              onChange: (value) {
                currentIndex = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 10),

            chatsList
                ? SizedBox.shrink()
                : CustomSectionsTabsBody(currentIndex: currentIndex),
            BlocBuilder<GetUserChatsCubit, GetUserChatsStates>(
              builder: (context, state) {
                if (state is SuccessGetUserChatsState) {
                  return Expanded(
                    child: ChatItemListView(chats: state.userWithChatList),
                  );
                } else if (state is EmptyGetUserChatsState) {
                  return NoConversationsWidget(
                    onChange: (value) {
                      widget.onChange(value);
                    },
                  );
                }
                // this is the intial state of ui before exist any chat or any body tap!!!!!
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
