import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      this.initialValue,
      this.hintText,
      this.obscureText = false,
      this.controller});

  final String? initialValue;
  final String? hintText;
  final bool obscureText;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.surfaceContainer),
      borderRadius: BorderRadius.circular(12),
    );

    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.5),
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        focusedErrorBorder: inputBorder,
      ),
    );
  }
}
