import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_cubit.dart';

class SignOutBlocProvider extends StatelessWidget {
  const SignOutBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(profileRepo: getIt.get<ProfileRepo>()),
      child: child,
    );
  }
}
