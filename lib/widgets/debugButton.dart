import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app_1/pages/home_pg.dart';

class DebugButton extends StatelessWidget {
  const DebugButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 300,
      child: TextButton(
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final idU = prefs.getInt("id");
          final resp1count = await dio.get(
            'https://fastapi-simple-notes.vercel.app/notes/amount/${prefs.getInt("id")}',
          );
          talker.log(resp1count);
          final response = await dio.get(
              "https://fastapi-simple-notes.vercel.app/notes/",
              queryParameters: {"user_id": idU});
          talker.log(response);
        },
        child: Text("debug"),
      ),
    );
  }
}
