import 'package:flutter/material.dart';

class TFField extends StatelessWidget {
  const TFField({
    super.key,
    required this.controller, required this.hint,
  });
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: hint,
      ),
    );
  }
}
