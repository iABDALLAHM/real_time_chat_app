import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: NotificationViewBody(),
    );
  }
}
