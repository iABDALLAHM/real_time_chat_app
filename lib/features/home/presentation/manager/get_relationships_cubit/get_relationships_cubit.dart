import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_relationships_cubit/get_relationships_state.dart';

// class GetRelationshipsCubit extends Cubit<GetRelationshipsStates> {
//   GetRelationshipsCubit({required this.mainRepo})
//     : super(InitialGetRelationshipsState());
//   final MainRepo mainRepo;

//   void getRelationShip({required String userId}) async {
//     emit(LoadingGetRelationshipsState());

//     // load sent friend requests
//     await for (var result in mainRepo.getSentFriendRequestStream(
//       userId: userId,
//     )) {
//       emit(SuccessGetRelationshipsState());
//     }
//     // load recived friend request
//     await for (var result in mainRepo.getFriendRequestStream(userId: userId)) {
//       emit(SuccessGetRelationshipsState());
//     }

//     // load friends/friendsShip
//     await for (var result in mainRepo.getFriendsStream(userId: userId)) {
//       emit(SuccessGetRelationshipsState());
//     }
//   }
// }
