import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
    required this.prefixIcon,
  });
  final String labelText, hintText;
  final Function(String?) onSaved;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 0),
        labelText: labelText,
        prefixIcon: prefixIcon,
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "";
        } else {
          return null;
        }
      },
    );
  }
}
