import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_app_1/logger.dart';
import 'package:test_app_1/main_dep.dart';
import 'package:test_app_1/widgets/note.dart';

//finals field
final dio = Dio();
final talker = TalkerFlutter.init();

//=================================================================================================================
class NotesListBuilder extends StatelessWidget {
  ///Notes list builder widget
  const NotesListBuilder({
    super.key,
    required this.notesCount,
    required this.noteMapT,
    required this.noteMapC,
    required this.noteMapI,
  });
  final int notesCount;
  final List<String> noteMapT;
  final List<String> noteMapC;
  final List<int> noteMapI;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notesCount,
      itemBuilder: ((context, index) {
        return Note(
          noteText: noteMapC[index],
          noteTitle: noteMapT[index],
          id: noteMapI[index],
        );
      }),
    );
  }
}

//=================================================================================================================
///runtime deserialize future (WIP)
Future VerifC() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userid = prefs.getInt("id")!;
    final resp1count = await dio.get(
      'https://fastapi-simple-notes.vercel.app/notes/amount/$userid',
    );
    final amountMap = jsonDecode(resp1count.toString()) as Map<String, dynamic>;
    final amount = notesAmount.fromJson(amountMap);
    await prefs.setInt("amount", amount.amount);
    var a = amount.amount;
    talker.log(
        'log_point_0, response count successful, DATA: {UserId = $userid; resp1count = $resp1count');

    final response = await dio.get(
        "https://fastapi-simple-notes.vercel.app/notes/",
        queryParameters: {"user_id": userid});
    talker.log(
        'log_point_0.1, response notes successful, DATA: {UserId = $userid; response = $response');

    List<JsonInitNote> notes = [];
    final noteMap = jsonDecode(response.toString()) as Map<String, dynamic>;
    talker.log(
        'log_point_1, serialize successful, DATA: {amountMap = $amountMap; amount = $amount; a = $a; noteMap = $noteMap}');

    for (var i = 0; i < a; i++) {
      final newNote = JsonInitNote.fromJson(noteMap["notes"][i]);
      notes.add(newNote);
    }
    Log("notes = $notes", 2, "serialize notes");

    return notes;

  } catch (error) {
    talker.error('error code: 3 $error');
  }
}

//=================================================================================================================
///notes serialize class
class JsonInitNote {
  final String title;
  final String content;
  final int id;
  JsonInitNote(
    this.title,
    this.content,
    this.id,
  );

  JsonInitNote.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        content = json["content"],
        id = json['id'];
}

class notesAmount {
  final dynamic amount;

  notesAmount(
    this.amount,
  );

  notesAmount.fromJson(Map<String, dynamic> json)
      : amount = json['amount'] as int;
}