import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_cubit.dart';

class ProfileMultiBlocProvider extends StatelessWidget {
  const ProfileMultiBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignOutCubit(profileRepo: getIt.get<ProfileRepo>()),
          child: child,
        ),
        BlocProvider(
          create: (context) =>
              DeleteAccountCubit(profileRepo: getIt.get<ProfileRepo>()),
          child: child,
        ),
      ],
      child: child,
    );
  }
}
