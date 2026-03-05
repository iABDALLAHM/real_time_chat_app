import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/respond_to_friend_request_cubit/respond_to_friend_request_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class RespondToFriendRequestCubit extends Cubit<RespondToFriendRequestStates> {
  RespondToFriendRequestCubit({required this.mainRepo})
    : super(InitialRespondToFriendRequestState());
  final MainRepo mainRepo;

  void respondToFriendRequest({
    required FriendRequestStatus friendRequestStatus,
    required String requestId,
  }) async {
    emit(LoadingRespondToFriendRequestState());
    var result = await mainRepo.respondToFriendRequest(
      requestId: requestId,
      status: friendRequestStatus,
    );
    result.fold(
      (L) {
        emit(FailureRespondToFriendRequestState());
      },
      (R) {
        emit(SuccessRespondToFriendRequestState());
      },
    );
  }
}
