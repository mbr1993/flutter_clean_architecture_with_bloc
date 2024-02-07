import 'package:flutter/material.dart';

TextFormField customFormField({
  required String key,
  required TextEditingController controller,
  required String labelText,
  required IconData prefixIcon,
  required bool? obscureText,
  required String? Function(String?)? validator,
  required TextInputType? keyboardType,
  required bool isSuffixIcon,
  required Widget? suffixIcon,
  required String hintText,
}) {
  return TextFormField(
    key: Key(key),
    style: const TextStyle(fontSize: 14, color: Colors.deepPurple),
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon, color: Colors.black26),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepPurpleAccent),
      ),
      contentPadding: const EdgeInsets.only(left: 10, right: 10),
      labelText: labelText,
      hintStyle: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      suffixIcon: isSuffixIcon ? suffixIcon : null,
      hintText: hintText,
    ),
    autocorrect: false,
    obscureText: obscureText ?? false,
    validator: validator,
    keyboardType: keyboardType,
  );
}
