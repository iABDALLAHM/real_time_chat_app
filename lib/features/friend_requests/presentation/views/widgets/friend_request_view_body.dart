import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/custom_tap_button.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/recevied_request_tap.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/views/widgets/sent_request_tap.dart';

class FriendRequestViewBody extends StatefulWidget {
  const FriendRequestViewBody({super.key});

  @override
  State<FriendRequestViewBody> createState() => _FriendRequestViewBodyState();
}

class _FriendRequestViewBodyState extends State<FriendRequestViewBody> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTapButton(
                  icon: Icons.inbox,
                  text: "Recevied",
                  isSelected: selectedIndex == 0 ? true : false,
                  onPressed: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: CustomTapButton(
                  icon: Icons.send,
                  text: "Sent",
                  isSelected: selectedIndex == 1 ? true : false,
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: [
              ReceviedRequestTap(),
              SentRequestTap(),
            ],
          ),
        ),
      ],
    );
  }
}






