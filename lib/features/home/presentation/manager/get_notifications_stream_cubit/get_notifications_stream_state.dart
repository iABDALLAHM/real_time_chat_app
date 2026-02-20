import 'package:real_time_chat_app/core/entities/notification_entity.dart';

abstract class GetNotificationsStreamStates {}

final class InitialGetNotificationsStreamState
    extends GetNotificationsStreamStates {}

final class LoadingGetNotificationsStreamState
    extends GetNotificationsStreamStates {}

final class SuccessGetNotificationsStreamState
    extends GetNotificationsStreamStates {
      final List<NotificationEntity> notificationsList;

  SuccessGetNotificationsStreamState({required this.notificationsList});
    }

final class FailureGetNotificationsStreamState
    extends GetNotificationsStreamStates {}
