import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/accept_friend_request_icon.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/new_friend_request_icon.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key, required this.notificationEntity});
  final NotificationEntity notificationEntity;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.notificationEntity.isRead == true
            ? AppTheme.cardColor
            : AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          setState(() {});
          context.read<NotificationsCubit>().markNotificationAsRead(
            notificationId: widget.notificationEntity.id,
          );
          // here when i pressed on it the color of the card must changed to express about i see the notification and also the icon must me disappeared that is behind a notification title;
        },
        child: ListTile(
          trailing: GestureDetector(
            onTap: () {
              context.read<NotificationsCubit>().deleteNotification(
                notificationId: widget.notificationEntity.id,
              );
            },
            child: Icon(Icons.close, size: 20),
          ),
          leading: getNotificationTypeIcon(
            notificationType: widget.notificationEntity.type,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.notificationEntity.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.notificationEntity.isRead == false)
                    Container(
                      decoration: ShapeDecoration(
                        color: AppTheme.primaryColor,
                        shape: OvalBorder(),
                      ),
                      width: 10,
                      height: 10,
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.notificationEntity.body,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
                "${widget.notificationEntity.createdAt.day.toString()}-${widget.notificationEntity.createdAt.month.toString()}-${widget.notificationEntity.createdAt.year.toString()}",
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
        return SizedBox.shrink();
      case NotificationType.newMessage:
        return SizedBox.shrink();
      case NotificationType.friendRemoved:
        return SizedBox.shrink();
    }
  }
}
