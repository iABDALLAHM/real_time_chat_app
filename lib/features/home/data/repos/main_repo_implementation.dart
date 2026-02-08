import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/models/user_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class MainRepoImplementation implements MainRepo {
  final DataBaseService dataBaseService;
  MainRepoImplementation({required this.dataBaseService});

  @override
  Stream<List<UserEntity>> getAllUsers() async* {
    List<UserEntity> usersList = [];
    var usersSnapshots = dataBaseService.getAllUsersStream(
      path: BackendEndPoints.getUsers,
    );
    for (var user in (usersSnapshots as List<Map<String, dynamic>>)) {
      usersList.add(UserModel.fromMap(user).toEntity());
    }
    yield usersList;
  }
}
