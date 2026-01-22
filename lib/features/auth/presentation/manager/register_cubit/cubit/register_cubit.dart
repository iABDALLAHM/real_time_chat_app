import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/register_cubit/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit({required this.authRepo}) : super(InitialRegisterState());
  final AuthRepo authRepo;
  Future register({
    required String email,
    required String name,
    required String password,
  }) async {
    emit(LoadingRegisterState());
    var result = await authRepo.register(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) {
        emit(FailureRegisterState(errMessage: failure.errMessage));
      },
      (success) {
        emit(SuccessRegisterState());
      },
    );
  }
}
