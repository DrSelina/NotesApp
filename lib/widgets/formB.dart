import 'package:flutter/material.dart';
import 'package:test_app_1/main_dep.dart';

// ignore: must_be_immutable
class FormButton extends StatelessWidget {
  VoidCallback onPressed;
  final String text;
  FormButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
