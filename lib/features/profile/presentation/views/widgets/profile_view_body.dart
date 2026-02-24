import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/cubits/user_stream_cubit/user_data_stream_cubit.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_field.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/profile/controllers/profile_controller.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_user_data_cubit/update_user_data_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/custom_profile_image.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/online_or_offline_status.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/personal_user_info.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/profile_body_footer.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/update_personal_information_bloc_listener.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/user_joined_date.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late TextEditingController nameController = TextEditingController();
  late String name, email;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = context.watch<ProfileController>();
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
                  PersonalUserInfo(),
                  const SizedBox(height: 8),
                  OnlineOrOfflineStatus(),
                  const SizedBox(height: 8),
                  UserJoinedDate(),
                  const SizedBox(height: 32),
                  UpdatePersonalInformationBlocListener(
                    child: Card(
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
                              isEnabled: profileController.isEditing,
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
                            profileController.isEditing
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
                                              .read<UserDataStreamCubit>()
                                              .getUserStream(
                                                userId: getUserData().uId,
                                              );
                                          triggerUpdateUserDataCubit(
                                            context,
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
                  ),
                  const SizedBox(height: 32),
                  ProfileBodyFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void triggerUpdateUserDataCubit(
    BuildContext context, {
    required UserEntity userEntity,
  }) {
    context.read<UpdateUserDataCubit>().updateUserInfo(userEntity: userEntity);
  }
}
