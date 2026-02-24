import 'package:real_time_chat_app/core/entities/user_with_chat_entity.dart';

abstract class GetUserChatsStates {}

final class InitialGetUserChatsState extends GetUserChatsStates {}

final class LoadingGetUserChatsState extends GetUserChatsStates {}

final class EmptyGetUserChatsState extends GetUserChatsStates {}

final class SuccessGetUserChatsState extends GetUserChatsStates {
  final List<UserWithChatEntity> userWithChatList;

  SuccessGetUserChatsState({required this.userWithChatList});
}

final class FailureGetUserChatsState extends GetUserChatsStates {}
