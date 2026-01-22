import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static const String routeName = "register";
  @override
  Widget build(BuildContext context) {
    return RegisterBlocProvider(child: Scaffold(body: RegisterViewBody()));
  }
}

class RegisterBlocProvider extends StatelessWidget {
  const RegisterBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(authRepo: getIt.get<AuthRepo>()),
      child: child,
    );
  }
}
