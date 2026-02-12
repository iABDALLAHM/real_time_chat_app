import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class SendFriendRequestCubit extends Cubit<UserRelationshipStatus> {
  SendFriendRequestCubit({required this.mainRepo})
    : super(UserRelationshipStatus.none);
  final MainRepo mainRepo;

  void sendRequest({required FriendRequestEntity friendRequestEntity}) async {
    await mainRepo.sendFriendRequest(friendRequest: friendRequestEntity);
    emit(UserRelationshipStatus.friendRequestSent);
  }

  void cancelFriend({required  String requestId}) async {
    await mainRepo.cancelFriendRequest(requestId: requestId);
    emit(UserRelationshipStatus.none);
  }
}
