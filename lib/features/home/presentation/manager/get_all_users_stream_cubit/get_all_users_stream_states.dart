import 'package:real_time_chat_app/core/entities/user_entity.dart';

abstract class GetAllUsersStreamStates {}

final class InitialGetAllUsersState extends GetAllUsersStreamStates {}


final class LoadingGetAllUsersState extends GetAllUsersStreamStates {}

final class SuccessGetAllUsersState extends GetAllUsersStreamStates {
  final List<UserEntity> users;

  SuccessGetAllUsersState({required this.users});
}

final class FailureGetAllUsersState extends GetAllUsersStreamStates {}
