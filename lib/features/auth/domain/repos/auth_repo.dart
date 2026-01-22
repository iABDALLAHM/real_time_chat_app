import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
  });
}
