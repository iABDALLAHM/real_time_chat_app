import 'package:real_time_chat_app/core/entities/user_entity.dart';

abstract class UserStreamStates {}

final class InitialUserStreamState extends UserStreamStates {}

final class LoadingUserStreamState extends UserStreamStates {}

final class SuccessUserStreamState extends UserStreamStates {
  final UserEntity userEntity;

  SuccessUserStreamState({required this.userEntity});
}
