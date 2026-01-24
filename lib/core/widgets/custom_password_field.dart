import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.onSaved,
    this.controller,
    required this.validator,
  });
  final String labelText, hintText;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onSaved: widget.onSaved,
      obscureText: isPassword,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 0),
        suffixIcon: GestureDetector(
          onTap: () {
            isPassword = !isPassword;
            setState(() {});
          },
          child: isPassword
              ? Icon(Icons.visibility_off_outlined)
              : Icon(Icons.remove_red_eye_outlined),
        ),
        labelText: widget.labelText,
        prefixIcon: Icon(Icons.lock_outline),
        hintText: widget.hintText,
      ),
      validator: widget.validator,
    );
  }
}
