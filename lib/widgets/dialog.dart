import 'package:flutter/material.dart';
import 'package:test_app_1/main_dep.dart';
import 'package:test_app_1/widgets/formB.dart';
import 'package:test_app_1/widgets/tffield.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave, required this.controller2,
  });
  final TextEditingController controller;
  final TextEditingController controller2;
  VoidCallback onSave;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TFField(controller: controller, hint: "Title",),
              SizedBox(height: 10,),
              TFField(controller: controller2, hint: "Enter your note:"),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FormButton(
                    onPressed: onSave,
                    text: "Save",
                  ),
                  FormButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: "Cancel",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
