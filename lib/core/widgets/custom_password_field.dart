import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
  });
  final String labelText, hintText;
  final Function(String?) onSaved;
  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
              ? Icon(Icons.visibility_off)
              : Icon(Icons.remove_red_eye),
        ),
        labelText: widget.labelText,
        prefixIcon: Icon(Icons.lock_outline),
        hintText: widget.hintText,
      ),
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
    );
  }
}
