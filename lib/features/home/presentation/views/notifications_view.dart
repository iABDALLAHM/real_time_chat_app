import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/notification_view_bloc_provider.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationViewBlocProvider(
      child: Scaffold(
        appBar: buildNotificationViewAppBar(context),
        body: NotificationsViewBody(),
      ),
    );
  }

  AppBar buildNotificationViewAppBar(BuildContext context) {
    return AppBar(
      title: Text("Notifications"),
      actions: [
        InkWell(
          onTap: () {
            // when i pressed here all notification on my list(view) must be transformeed to a seen notification and => primary Color disapperad and icon also disaapeard;
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "Mark all read",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
