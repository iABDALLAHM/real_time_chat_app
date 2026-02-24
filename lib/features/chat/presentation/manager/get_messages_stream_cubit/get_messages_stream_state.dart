import 'package:real_time_chat_app/core/entities/message_entity.dart';

abstract class GetMessagesStreamStates {}

final class InitialGetMessagesStreamState extends GetMessagesStreamStates {}

final class SuccessGetMessagesStreamState extends GetMessagesStreamStates {
  final List<MessageEntity> messagesList;

  SuccessGetMessagesStreamState({required this.messagesList});
}

final class LoadingGetMessagesStreamState extends GetMessagesStreamStates {}

final class EmptyMessagesStreamState extends GetMessagesStreamStates {}
