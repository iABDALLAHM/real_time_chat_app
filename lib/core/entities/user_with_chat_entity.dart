import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';

class UserWithChatEntity {
  final UserEntity userEntity;
  final ChatEntity chatEntity;

  UserWithChatEntity({required this.userEntity, required this.chatEntity});
  
}