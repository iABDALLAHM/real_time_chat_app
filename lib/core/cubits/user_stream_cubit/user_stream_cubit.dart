import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_state.dart';

class UserStreamCubit extends Cubit<UserStreamStates> {
  UserStreamCubit({required this.profileRepo})
    : super(InitialUserStreamState());
  final ProfileRepo profileRepo;
  void getUserStream({required String userId}) async {
    emit(LoadingUserStreamState());
    await for (var result in (profileRepo.getUserStream(uId: userId))) {
      emit(SuccessUserStreamState(userEntity: result));
    }
  }
}
