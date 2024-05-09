import 'package:flutter/material.dart';
import 'package:test_app_1/main_dep.dart';

// ignore: must_be_immutable
class Note extends StatelessWidget {
  Note({
    super.key,
    required this.noteText,
    required this.noteTitle,
    this.id,
  });
  final String noteText;
  final String noteTitle;
  final int? id;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                child: Column(
                  children: [
                    Text(noteTitle),
                    Text(
                      noteText,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  await dio.delete("https://fastapi-simple-notes.vercel.app/notes/$id");
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
