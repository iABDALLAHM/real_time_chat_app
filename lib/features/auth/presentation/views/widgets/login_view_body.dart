import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_password_field.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/login_rich_text.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isPressed = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 80,
                height: 80,
                child: Icon(
                  Icons.chat_bubble_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Welcome Back!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "Sign in to continue chatting with friends & family",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                onSaved: (value) {},
                labelText: "Email",
                hintText: "Enter your email",
              ),
              const SizedBox(height: 16),
              CustomPasswordField(
                onSaved: (value) {},
                labelText: "Password",
                hintText: "Enter your password",
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  child: isPressed
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text("Sign In"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // isPressed = !isPressed;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              LoginRichText(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider(color: AppTheme.borderColor)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "OR",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Expanded(child: Divider(color: AppTheme.borderColor)),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed(routeName)
                    },
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
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
