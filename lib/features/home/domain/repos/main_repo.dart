import 'package:real_time_chat_app/core/entities/user_entity.dart';

abstract class MainRepo {
  Stream<List<UserEntity>> getAllUsers();
}
