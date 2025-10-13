import 'package:flutter/material.dart';
import 'package:travel_hub/constant.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool obscureText;
  final IconData? suffixIcon;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        labelText: label,
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBackgroundColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBackgroundColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
