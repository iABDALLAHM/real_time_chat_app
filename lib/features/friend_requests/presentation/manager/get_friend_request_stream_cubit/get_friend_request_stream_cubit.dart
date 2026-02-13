import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_state.dart';

class GetFriendRequestStreamCubit extends Cubit<GetFriendRequestStreamStates> {
  GetFriendRequestStreamCubit() : super(InitialGetFriendRequestStreamState());
}
