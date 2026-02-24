import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_user_data_cubit/update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataStates> {
  UpdateUserDataCubit({required this.profileRepo})
    : super(InitialUpdateUserDataState());
  final ProfileRepo profileRepo;
  Future<void> updateUserInfo({required UserEntity userEntity}) async {
    emit(LoadingUpdateUserDataState());
    await profileRepo.updateUserInfo(userEntity: userEntity);
    emit(SuccessUpdateUserDataState());
  }
}
