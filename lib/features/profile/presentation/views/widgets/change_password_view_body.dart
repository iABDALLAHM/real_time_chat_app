import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_password_field.dart';
import 'package:real_time_chat_app/features/profile/presentation/manager/update_password_cubit/update_password_cubit.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/update_password_bloc_listener.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late TextEditingController passwordController,
      confirmPasswordController,
      oldPasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String oldPassword, newPassword, confirmPassword;
  bool isLoading = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    oldPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpdatePasswordBlocListener(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.security_rounded,
                    size: 40,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Update Your Password",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Enter Your current password and choose a new secure password",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 40),
              CustomPasswordField(
                controller: oldPasswordController,
                onSaved: (value) {
                  oldPassword = value!;
                },
                labelText: "Current Password",
                hintText: "Enter Current Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 8),
              CustomPasswordField(
                controller: passwordController,
                onSaved: (value) {
                  newPassword = value!;
                },
                labelText: "New Password",
                hintText: "Enter Your New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 8),
              CustomPasswordField(
                controller: confirmPasswordController,
                onSaved: (value) {
                  confirmPassword = value!;
                },
                labelText: "Confirm New Password",
                hintText: "Confirm Your New Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "the password does not match";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<UpdatePasswordCubit>().updatePassword(
                        newPassword: newPassword,
                      );
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.security),
                            const SizedBox(width: 8),
                            Text("Update password"),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
