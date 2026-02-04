  import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_notification_icon.dart';

AppBar buildChatBodyAppBar() {
    return AppBar(
      title: Text(
        "Messages",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
      leading: SizedBox(),
      actions: [CustomNotificationIcon()],
    );
  }