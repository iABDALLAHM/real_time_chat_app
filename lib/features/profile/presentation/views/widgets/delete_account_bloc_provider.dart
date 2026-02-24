

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/services/get_it_service.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';

class DeleteAccountViewBlocProvider extends StatelessWidget {
  const DeleteAccountViewBlocProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return         BlocProvider(
      
          create: (context) =>
              DeleteAccountCubit(profileRepo: getIt.get<ProfileRepo>()),
            child: child,  
        );
  }
}