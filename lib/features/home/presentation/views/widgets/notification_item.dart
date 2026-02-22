import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/accept_friend_request_icon.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/new_friend_request_icon.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notificationEntity});
  final NotificationEntity notificationEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.close, size: 20),
          ),
          leading: getNotificationTypeIcon(
            notificationType: notificationEntity.type,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    notificationEntity.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  notificationEntity.isRead == false
                      ? Container(
                          decoration: ShapeDecoration(
                            color: AppTheme.primaryColor,
                            shape: OvalBorder(),
                          ),
                          width: 10,
                          height: 10,
                        )
                      : SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                notificationEntity.body,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
                "${notificationEntity.createdAt.day.toString()}-${notificationEntity.createdAt.month.toString()}-${notificationEntity.createdAt.year.toString()}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getNotificationTypeIcon({required NotificationType notificationType}) {
    switch (notificationType) {
      case NotificationType.friendRequest:
        return NewFriendRequestIcon();
      case NotificationType.friendRequestAccepted:
        return AcceptedFriendRequestIcon();
      case NotificationType.friendRequestDecliend:
        throw UnimplementedError();
      case NotificationType.newMessage:
        throw UnimplementedError();
      case NotificationType.friendRemoved:
        throw UnimplementedError();
    }
  }
}
