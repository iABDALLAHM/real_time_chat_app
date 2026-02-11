import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/send_friend_request_cubit/send_friend_request_state.dart';

class SendFriendRequestCubit extends Cubit<SendFriendRequestStates> {
  SendFriendRequestCubit({required this.mainRepo})
    : super(InitialSendFriendRequestState());
  final MainRepo mainRepo;

  void sendRequest({required FriendRequestEntity friendRequestEntity}) async {
    emit(LoadingSendFriendRequestState());
    await mainRepo.sendFriendRequest(friendRequest: friendRequestEntity);
    emit(SuccessSendFriendRequestState());
  }
}
