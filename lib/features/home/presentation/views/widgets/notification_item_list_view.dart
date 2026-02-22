import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/notification_item.dart';

class NotificationItemListView extends StatelessWidget {
  const NotificationItemListView({super.key, required this.notificationsList});
  final List<NotificationEntity> notificationsList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notificationsList.length,
      itemBuilder: (context, index) {
        return NotificationItem(notificationEntity: notificationsList[index]);
      },
    );
  }
}
