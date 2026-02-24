import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_password_cubit/update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordStates> {
  UpdatePasswordCubit({required this.profileRepo})
    : super(InitialUpdatePasswordState());
  final ProfileRepo profileRepo;

  Future<void> updatePassword({required String newPassword}) async {
    emit(LoadingUpdatePasswordState());
    await profileRepo.updateUserPassword(newPassword: newPassword);
    emit(SuccessUpdatePasswordState());
  }
}
