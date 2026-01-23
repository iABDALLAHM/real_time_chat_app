import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_password_field.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/auth/presentation/manager/register_cubit/cubit/register_cubit.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/custom_or_section.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/register_rich_text.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  late TextEditingController passwordController, confirmPasswordController;
  late String email, name, password;
  bool isPressed = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        autovalidateMode: autovalidateMode,
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Fill in your details to get started",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textsecondaryColor,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                prefixIcon: Icon(Icons.person_outlined),
                onSaved: (value) {
                  name = value!;
                },
                labelText: "Display Name",
                hintText: "Enter your name",
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                prefixIcon: Icon(Icons.email_outlined),
                onSaved: (value) {
                  email = value!;
                },
                labelText: "Email",
                hintText: "Enter your email",
              ),
              const SizedBox(height: 16),
              CustomPasswordField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  if (value.length < 6) {
                    return "password must be at least 6 characters";
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                onSaved: (value) {
                  password = value!;
                },
                labelText: "Password",
                hintText: "Enter your password",
              ),
              const SizedBox(height: 16),
              CustomPasswordField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  if (value.length < 6) {
                    return "password must be at least 6 characters";
                  } else {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return "password do not match";
                    }
                    return null;
                  }
                },
                controller: confirmPasswordController,

                labelText: "Confirm Password",
                hintText: "Confirm your password",
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
                      : Text("Create Accout"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      isPressed = true;
                      triggerRegisterCubit(context);
                      setState(() {});
                      isPressed = false;
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              CustomOrSection(),
              const SizedBox(height: 32),
              RegisterRichText(),
            ],
          ),
        ),
      ),
    );
  }

  void triggerRegisterCubit(BuildContext context) {
    context.read<RegisterCubit>().register(
      email: email,
      name: name,
      password: password,
    );
  }
}
