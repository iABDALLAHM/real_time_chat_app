import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_all_users_stream_cubit/get_all_users_stream_states.dart';

class GetAllUsersStreamCubit extends Cubit<GetAllUsersStreamStates> {
  GetAllUsersStreamCubit({required this.mainRepo})
    : super(InitialGetAllUsersState());
  final MainRepo mainRepo;
  void getAllUsers() async {
    emit(LoadingGetAllUsersState());
    await for (var users in mainRepo.getAllUsersStream()) {
      // StateError (Bad state: Cannot emit new states after calling close) دي المشكلة لازم تتحل
      emit(SuccessGetAllUsersState(users: users));
    }
  }
}
