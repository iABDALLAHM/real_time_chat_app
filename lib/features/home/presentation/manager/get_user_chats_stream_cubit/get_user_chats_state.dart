import 'package:real_time_chat_app/core/entities/chat_entity.dart';

abstract class GetUserChatsStates {}

final class InitialGetUserChatsState extends GetUserChatsStates {}

final class LoadingGetUserChatsState extends GetUserChatsStates {}

final class EmptyGetUserChatsState extends GetUserChatsStates {}

final class SuccessGetUserChatsState extends GetUserChatsStates {
  final List<ChatEntity> chats;

  SuccessGetUserChatsState({required this.chats});
}

final class FailureGetUserChatsState extends GetUserChatsStates {}
