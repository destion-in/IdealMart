import 'package:flutter/material.dart';

class BorderTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget?
      suffixIcon; // Made nullable to handle cases where no suffix icon is needed
  final Widget? prefixIcon; // Made nullable for the same reason as suffixIcon
  final double borderRadius;
  final TextEditingController?
      controller; // Made nullable to handle cases where no controller is passed
  final TextInputType?
      keyboardType; // Allow specifying different types of input keyboards
  final String?
      obscuringCharacter; // Optional character to obscure text in password fields

  BorderTextField({
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 8.0,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscuringCharacter = '•',
    required String? Function(dynamic value) validator,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter:
          obscuringCharacter!, // Use the obscuring character if specified
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(12), // Uniform padding
        constraints: BoxConstraints(
          minHeight: height * 0.06, // Height proportional to screen height
          maxHeight: height * 0.06,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
    );
  }
}
