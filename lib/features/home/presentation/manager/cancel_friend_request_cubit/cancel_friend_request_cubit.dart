import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class CancelFriendRequestCubit extends Cubit<UserRelationshipStatus> {
  CancelFriendRequestCubit({required this.mainRepo})
    : super(UserRelationshipStatus.friendRequestSent);
  final MainRepo mainRepo;

  void cancelFriend({required String requestId}) async {
    emit(UserRelationshipStatus.friendRequestSent);
    var result = await mainRepo.cancelFriendRequest(requestId: requestId);
    result.fold(
      (L) {
        emit(UserRelationshipStatus.friendRequestSent);
      },
      (R) {
        emit(UserRelationshipStatus.none);
      },
    );
  }
}
