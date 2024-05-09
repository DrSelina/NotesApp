import 'package:flutter/material.dart';
import 'package:test_app_1/widgets/note.dart';

class TestListViewB extends StatelessWidget {
  TestListViewB({
    super.key,
  });
  final List<String> objects = ["note1", "note2"];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objects.length,
        itemBuilder: ((context, index) {
          return Note(noteText: objects[index-1], noteTitle: objects[index + 1]);
        }));
  }
}
