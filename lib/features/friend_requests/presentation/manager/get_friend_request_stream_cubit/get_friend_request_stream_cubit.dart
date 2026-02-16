import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class GetFriendRequestStreamCubit extends Cubit<GetFriendRequestStreamStates> {
  GetFriendRequestStreamCubit({required this.mainRepo})
    : super(InitialGetFriendRequestStreamState());
  final MainRepo mainRepo;

  void getFriendRequestStream({required String userId}) async {
    emit(LoadingGetFriendRequestStreamState());
    var friendRequestEntityList = mainRepo.getFriendRequestStream(
      userId: userId,
    );
    await for (var user in friendRequestEntityList) {
      emit(SuccessGetFriendRequestStreamState(friendRequestList: user));
    }
  }
}
