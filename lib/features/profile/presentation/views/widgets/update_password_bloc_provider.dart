

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_password_cubit/update_password_cubit.dart';

class UpdatePasswordBlocProvider extends StatelessWidget {
  const UpdatePasswordBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdatePasswordCubit(profileRepo: getIt.get<ProfileRepo>()),
      child: child,
    );
  }
}
