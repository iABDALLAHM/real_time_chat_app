import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_stream_cubit.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_field.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/auth/presentation/function/show_top_overlay_message.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/login_view.dart';
import 'package:real_time_chat_app/features/profile/controllers/profile_controller.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/delete_account_cubit/delete_account_state.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/sign_out_cubit/sign_out_state.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_user_data_cubit/update_user_data_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_user_data_cubit/update_user_data_state.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/custom_profile_image.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/online_or_offline_status.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_body_footer.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/user_joined_date.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late TextEditingController nameController;
  late String name, email;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: autovalidateMode,
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomProfileImage(),
                  const SizedBox(height: 16),
                  Text(
                    getUserData().displayName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getUserData().email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textsecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OnlineOrOfflineStatus(),
                  const SizedBox(height: 8),
                  UserJoinedDate(),
                  const SizedBox(height: 32),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 32),
                          CustomTextFormField(
                            isEnabled: controller.isEditing,
                            controller: nameController,
                            labelText: "Display Name",
                            hintText: getUserData().displayName,
                            onSaved: (value) {
                              name = value!;
                            },
                            prefixIcon: Icon(Icons.person_outlined),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            isEnabled: false,
                            helperText: "Email can't be changed",
                            labelText: "Email",
                            hintText: getUserData().email,
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          const SizedBox(height: 16),
                          controller.isEditing
                              ? SizedBox(
                                  height: 54,
                                  width: double.infinity,
                                  child: CustomButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        UserEntity userEntity = UserEntity(
                                          uId: getUserData().uId,
                                          email: getUserData().email,
                                          displayName: nameController.text,
                                          lastSeen: DateTime.now(),
                                          isOnline: true,
                                          createdAt: DateTime.now(),
                                        );
                                        // trigger User Stream cubit.
                                        context
                                            .read<UserStreamCubit>()
                                            .getUserStream(
                                              userId: getUserData().uId,
                                            );
                                        context
                                            .read<UpdateUserDataCubit>()
                                            .updateUserInfo(
                                              userEntity: userEntity,
                                            );
                                        nameController.clear();
                                      } else {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      }
                                    },
                                    child: Text("Save Changes"),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  MultiBlocListener(
                    listeners: [
                      BlocListener<SignOutCubit, SignOutStates>(
                        listener: (context, state) {
                          if (state is SuccessSignOutState) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(LoginView.routeName);
                            showTopOverlayMessage(
                              context,
                              message: "Success SignOut",
                            );
                          }
                        },
                      ),
                      BlocListener<DeleteAccountCubit, DeleteAccountStates>(
                        listener: (context, state) {
                          if (state is SuccessDeleteAccountState) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(LoginView.routeName);
                            showTopOverlayMessage(
                              context,
                              message: "Success delete Account",
                            );
                          }
                        },
                      ),
                      BlocListener<UpdateUserDataCubit, UpdateUserDataStates>(
                        listener: (context, state) {
                          if (state is SuccessUpdateUserDataState) {
                            showTopOverlayMessage(
                              context,
                              message: "Success Update Data",
                            );
                          }
                        },
                      ),
                    ],
                    child: ProfileBodyFooter(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
