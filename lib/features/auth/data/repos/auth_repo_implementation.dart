import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/services/auth_service.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final AuthService authService;

  AuthRepoImplementation({required this.authService});
  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var user =
          await authService.register(
                name: name,
                email: email,
                password: password,
              )
              as User;
      UserEntity userEntity = UserEntity(
        uId: user.uid,
        email: email,
        displayName: name,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await authService.signInWithEmailAndPassword(
        password: password,
        email: email,
      );
      UserEntity userEntity = UserEntity(
        uId: "",
        email: email,
        displayName: "",
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await authService.sendPasswordResetEmail(email: email);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
