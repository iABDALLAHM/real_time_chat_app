import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountStates> {
  DeleteAccountCubit({required this.profileRepo})
    : super(InitialDeleteAccountState());
  final ProfileRepo profileRepo;

  Future deleteAccount({required String userId}) async {
    emit(LoadingDeleteAccountState());
    await profileRepo.deleteUser(userId: userId);
    emit(SuccessDeleteAccountState());
  }
}
