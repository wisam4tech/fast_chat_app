import 'package:flutter/material.dart';

class CustomFormTextfield extends StatelessWidget {
  CustomFormTextfield(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.obscureText = false});
  final String hintText;
  Function(String)? onChanged;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          hintText: hintText,
        ),
      ),
    );
  }
}
