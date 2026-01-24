import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/reset_password_cubit/reset_password_states.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit({required this.authRepo})
    : super(InitialResetPasswordState());
  final AuthRepo authRepo;
  Future resetPassword({required String email}) async {
    var result = await authRepo.resetPassword(email: email);
    result.fold(
      (failure) {
        emit(FailureResetPasswordState(errMessage: failure.errMessage));
      },
      (success) {
        emit(SuccessResetPasswordState());
      },
    );
  }
}
