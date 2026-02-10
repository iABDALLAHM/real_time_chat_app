import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/no_notification_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const String routeName = "notification";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: NoNotificationWidget(),
    );
  }
}
