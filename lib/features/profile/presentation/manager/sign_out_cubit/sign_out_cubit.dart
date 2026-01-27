import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutStates> {
  SignOutCubit({required this.profileRepo}) : super(InitialSignOutState());
  final ProfileRepo profileRepo;

  Future signOut({required String userId}) async {
    emit(LoadingSignOutState());
    await profileRepo.signOut(userId: userId);
    emit(SuccessSignOutState());
  }
}
