import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_cubit.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_state.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/no_notification_widget.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/notification_item.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetNotificationsStreamCubit,
      GetNotificationsStreamStates
    >(
      builder: (context, state) {
        if (state is SuccessGetNotificationsStreamState) {
          return NotificationItem();
        }
        return NoNotificationWidget();
      },
    );
  }
}
