import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/functions/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_user_data_cubit/update_user_data_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_user_data_cubit/update_user_data_state.dart';

class UpdatePersonalInformationBlocListener extends StatelessWidget {
  const UpdatePersonalInformationBlocListener({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return  BlocListener<UpdateUserDataCubit, UpdateUserDataStates>(
                        listener: (context, state) {
                          if (state is SuccessUpdateUserDataState) {
                            showTopOverlayMessage(
                              context,
                              message: "Success Update Data",
                            );
                          }
                        },
                        child:child ,
                      );
  }
}