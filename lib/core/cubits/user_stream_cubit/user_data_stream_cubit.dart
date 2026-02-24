import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_data_stream_state.dart';

class UserDataStreamCubit extends Cubit<UserStreamStates> {
  UserDataStreamCubit({required this.profileRepo})
    : super(InitialUserStreamState());
  final ProfileRepo profileRepo;
  StreamSubscription? _streamSubscription;
  void getUserStream({required String userId}) {
    emit(LoadingUserStreamState());
    _streamSubscription = profileRepo.getUserStream(uId: userId).listen((
      result,
    ) {
      emit(SuccessUserStreamState(userEntity: result));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
