import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/email_sent_content_bloc_builder.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/remember_password_section.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/reset_password_home_icon.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  String? emailResend;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: autovalidateMode,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Forgot password",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  "Enter your email to receive a password reset link",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textsecondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ResetPasswordHomeIcon(),
              const SizedBox(height: 40),
              EmailSentContentBlocBuilder(),
              const SizedBox(height: 40),
              CustomTextFormField(
                labelText: "Email Address",
                hintText: "Enter your email Address",
                onSaved: (value) {
                  emailResend = value!;
                },
                prefixIcon: Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 54,
                width: double.infinity,
                child: CustomButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send),
                      const SizedBox(width: 10),
                      Text("Send Reset Link"),
                    ],
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<ResetPasswordCubit>().resetPassword(
                        email: emailResend!,
                      );
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              RememberPasswordSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
