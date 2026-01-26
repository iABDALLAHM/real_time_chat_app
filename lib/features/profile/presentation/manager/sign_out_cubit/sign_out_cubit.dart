import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutStates> {
  SignOutCubit({required this.authRepo}) : super(InitialSignOutState());
  final AuthRepo authRepo;

  Future signOut({required String userId}) async {
    emit(LoadingSignOutState());
    await authRepo.signOut(userId: userId);
    emit(SuccessSignOutState());
  }
}
