import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_all_users_stream_cubit/get_all_users_stream_states.dart';

class GetAllUsersStreamCubit extends Cubit<GetAllUsersStreamStates> {
  GetAllUsersStreamCubit({required this.mainRepo})
    : super(InitialGetAllUsersState());
  final MainRepo mainRepo;
  StreamSubscription? _streamSubscription;
  void getAllUsers() {
    emit(LoadingGetAllUsersState());
    _streamSubscription = mainRepo.getAllUsersStream().listen((result) {
      emit(SuccessGetAllUsersState(users: result));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
