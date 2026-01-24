import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';

class LoginBlocProvider extends StatelessWidget {
  const LoginBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepo: getIt.get<AuthRepo>()),
      child: child,
    );
  }
}
