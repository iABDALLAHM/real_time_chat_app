import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({required this.authRepo}) : super(InitialLoginState());
  final AuthRepo authRepo;
  Future login({required String email, required String password}) async {
    emit(LoadingLoginState());
    var result = await authRepo.signIn(email: email, password: password);
    result.fold(
      (failure) {
        emit(FailureLoginState(errMessage: failure.errMessage));
      },
      (success) {
        emit(SuccessLoginState());
      },
    );
  }
}
