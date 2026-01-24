import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  late String emailResend;
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
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
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppTheme.primaryColor.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    size: 50,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // EmailSentContent(),
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
                    
                  },
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Remember Your Password?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailSentContent extends StatelessWidget {
  const EmailSentContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.successColor.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(
                Icons.mark_email_read_rounded,
                size: 60,
                color: AppTheme.successColor,
              ),
              const SizedBox(height: 16),
              Text(
                "Email Sent!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We've sent a password reset link to: ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "amabdgalil@gmail.com",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Check your email and follow the instructions to reset your password",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: Icon(Icons.refresh),
                  onPressed: () {},
                  label: Text("Resend Email"),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text("Back To Sign In"),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppTheme.secondaryColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Didn't receive the email? check to our spam folder or try again",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
